//
//  FormDetailsView.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDIIO
import SwiftUI

/// Modern details view.
@available(macOS 13.0, iOS 16.0, *)
struct FormDetailsView: View, DetailsContent {
    @EnvironmentObject private var model: Model
    
    var object: AnyMIDIIOObject

    init(object: AnyMIDIIOObject) {
        self.object = object
    }

    var body: some View {
        VStack {
            if let image = object.image.value {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 100)
                    .padding([.top], 20)
            }

            if let parentText {
                Text(parentText)
                    .padding([.top], 10)
                    .padding([.bottom], 2)
            }

            form
        }
        .onAppear {
            model.refreshProperties(object: object)
        }
        .onChange(of: model.isOnlySetPropertiesShown) { _ in
            withAnimation { model.refreshProperties(object: object) }
        }
        #if os(macOS)
        .navigationSubtitle(object.name)
        #elseif os(iOS)
        .navigationTitle(object.name)
        #endif
    }

    private var parentText: String? {
        switch object {
        case .device(_): // devices have no parents
            "A device."
        case let .entity(entity):
            if let deviceName = entity.device?.name {
                "An entity that belongs to device \(deviceName.quoted)"
            } else {
                "An entity that does not belong to a device."
            }
        case let .inputEndpoint(inputEndpoint):
            if let entityName = inputEndpoint.entity?.name {
                "An input endpoint that belongs to entity \(entityName.quoted)"
            } else {
                "An input endpoint that does not belong to an entity."
            }
        case let .outputEndpoint(outputEndpoint):
            if let entityName = outputEndpoint.entity?.name {
                "An output endpoint that belongs to entity \(entityName.quoted)"
            } else {
                "An output endpoint that does not belong to an entity."
            }
        }
    }

    private var form: some View {
        Form {
            if model.filteredProperties.isEmpty {
                Text("No search results match your search term.")
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
            } else {
                ForEach(model.filteredProperties) { property in
                    PropertyRowView(property: property)
                }
            }
        }
        .formStyle(.grouped)
    }

    struct PropertyRowView: View {
        var property: Property

        var body: some View {
            LabeledContent(property.key) {
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
