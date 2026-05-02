//
//  OtherOutputsView.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDIIO
import SwiftUI

extension ContentView {
    struct OtherOutputsView: View {
        @EnvironmentObject private var midiHelper: MIDIHelper

        @Binding var showRelevantProperties: Bool

        var body: some View {
            Section(header: Text("Other Outputs")) {
                ForEach(otherOutputs) { item in
                    navLink(item: item)
                }
            }
        }

        private func navLink(item: MIDIOutputEndpoint) -> some View {
            NavigationLink(destination: detailsView(item: item)) {
                HStack {
                    ItemIcon(item: item.asAnyMIDIIOObject(), default: Text("🎵"))
                    Text("\(item.name)")
                }
            }
        }

        private func detailsView(item: MIDIOutputEndpoint) -> some View {
            DetailsView(
                object: item.asAnyMIDIIOObject(),
                isRelevantPropertiesOnlyShown: $showRelevantProperties
            )
        }

        private var otherOutputs: [MIDIOutputEndpoint] {
            // filter out endpoints that have an entity because
            // they are already being displayed in the Devices tree
            midiHelper.endpoints?
                .outputs
                .sortedByName()
                .filter { $0.entity == nil }
                ?? []
        }
    }
}
