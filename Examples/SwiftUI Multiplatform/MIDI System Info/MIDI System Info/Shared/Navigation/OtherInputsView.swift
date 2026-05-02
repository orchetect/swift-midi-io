//
//  OtherInputsView.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDIIO
import SwiftUI

extension ContentView {
    struct OtherInputsView: View {
        @EnvironmentObject private var midiHelper: MIDIHelper

        var body: some View {
            Section(header: Text("Other Inputs")) {
                ForEach(otherInputs) { item in
                    navLink(item: item)
                }
            }
        }

        private func navLink(item: MIDIInputEndpoint) -> some View {
            NavigationLink(destination: detailsView(item: item)) {
                HStack {
                    ItemIcon(item: item.asAnyMIDIIOObject(), default: Text("🎵"))
                    Text("\(item.name)")
                    Spacer()
                }
            }
        }

        private func detailsView(item: MIDIInputEndpoint) -> some View {
            DetailsView(object: item.asAnyMIDIIOObject())
        }

        private var otherInputs: [MIDIInputEndpoint] {
            // filter out endpoints that have an entity because
            // they are already being displayed in the Devices tree
            midiHelper.endpoints?
                .inputs
                .sortedByName()
                .filter { $0.entity == nil }
                ?? []
        }
    }
}
