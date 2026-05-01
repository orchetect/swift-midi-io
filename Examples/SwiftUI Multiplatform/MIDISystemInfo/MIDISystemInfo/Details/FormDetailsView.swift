//
//  FormDetailsView.swift
//  SwiftMIDI Examples • https://github.com/orchetect/swift-midi-examples
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDIIO
import SwiftUI

/// Modern details view.
@available(macOS 13.0, iOS 16.0, *)
struct FormDetailsView: View, DetailsContent {
    var object: AnyMIDIIOObject
    @Binding var isOnlySetPropertiesShown: Bool

    @State var properties: [Property] = []
    @State var selection: Set<Property.ID> = []

    init(object: AnyMIDIIOObject, isRelevantPropertiesOnlyShown: Binding<Bool>) {
        self.object = object
        _isOnlySetPropertiesShown = isRelevantPropertiesOnlyShown
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

            form
        }
        .onAppear {
            refreshProperties()
        }
        .onChange(of: isOnlySetPropertiesShown) { _ in
            withAnimation { refreshProperties() }
        }
        #if os(macOS)
        .navigationSubtitle(object.name)
        #elseif os(iOS)
        .navigationTitle(object.name)
        #endif
    }

    private var form: some View {
        Form {
            ForEach(properties) { property in
                PropertyRowView(property: property)
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
