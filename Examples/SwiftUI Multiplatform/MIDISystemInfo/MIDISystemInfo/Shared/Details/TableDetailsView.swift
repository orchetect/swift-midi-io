//
//  TableDetailsView.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDIIO
import SwiftUI

/// Modern details view.
@available(macOS 12.0, iOS 16.0, *)
struct TableDetailsView: View, DetailsContent {
    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    private var isCompact: Bool {
        horizontalSizeClass == .compact
    }
    #else
    private let isCompact = false
    #endif

    var object: AnyMIDIIOObject
    @Binding var isOnlySetPropertiesShown: Bool

    @State var properties: [Property] = []
    @State var selection: Set<Property.ID> = []

    init(object: AnyMIDIIOObject, isRelevantPropertiesOnlyShown: Binding<Bool>) {
        self.object = object
        _isOnlySetPropertiesShown = isRelevantPropertiesOnlyShown
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            table
                #if os(macOS)
                .tableStyle(.inset(alternatesRowBackgrounds: true))
                .onCopyCommand {
                    selectedItemsProviders()
                }
                #elseif os(iOS)
                .tableStyle(InsetTableStyle())
                #endif
        }
        .onAppear {
            refreshProperties()
        }
        .onChange(of: isOnlySetPropertiesShown) { _ in
            withAnimation { refreshProperties() }
        }
    }

    @ViewBuilder
    private var table: some View {
        if isCompact {
            Table(properties, selection: $selection) {
                TableColumn("Property") { property in
                    HStack {
                        Text(property.key)

                        Spacer()

                        if let status = property.status {
                            status.view
                        }

                        Text(property.value)
                            .foregroundColor(property.color)
                    }
                }
            }
        } else {
            Table(properties, selection: $selection) {
                TableColumn("Property", value: \.key)
                #if os(macOS)
                    .width(min: 180, ideal: 200, max: 280)
                #elseif os(iOS)
                    .width(min: 50, ideal: 120, max: 250)
                #endif

                TableColumn("Value") { property in
                    HStack {
                        if let status = property.status {
                            status.view
                        }

                        Text(property.value)
                            .foregroundColor(property.color)
                    }
                }
            }
        }
    }
}
