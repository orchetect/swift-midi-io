//
//  LegacyDetailsView.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Combine
import SwiftMIDIIO
import SwiftUI

/// Legacy details view for systems prior to macOS 12 / iOS 16.
struct LegacyDetailsView: View, DetailsContent {
    @EnvironmentObject private var model: Model
    
    var object: AnyMIDIIOObject

    init(object: AnyMIDIIOObject) {
        self.object = object
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            List(selection: $model.selectedProperties) {
                Section {
                    if model.filteredProperties.isEmpty {
                        Text("No search results match your search term.")
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity)
                    } else {
                        ForEach(model.filteredProperties) {
                            Row(property: $0).tag($0)
                        }
                    }
                } header: {
                    Row(property: Property(key: "Property", value: "Value", status: nil))
                        .font(.headline)
                } footer: {
                    // empty
                }
            }
            #if os(macOS)
            .onCopyCommand {
                model.selectedItemsProviders()
            }
            #endif
        }
        .onAppear {
            model.refreshProperties(object: object)
        }
        .onChange(of: model.isOnlySetPropertiesShown) { _ in
            withAnimation { model.refreshProperties(object: object) }
        }
    }
}

extension LegacyDetailsView {
    private struct Row: View, Identifiable {
        nonisolated let property: Property

        nonisolated var id: Property.ID {
            property.id
        }

        var body: some View {
            HStack(alignment: .top) {
                Text(property.key)
                    #if os(macOS)
                    .frame(width: 220, alignment: .leading)
                    #elseif os(iOS)
                    .frame(width: 150, alignment: .leading)
                    #endif

                if let status = property.status {
                    status.view
                }

                Text(property.value)
                    .foregroundColor(property.color)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
