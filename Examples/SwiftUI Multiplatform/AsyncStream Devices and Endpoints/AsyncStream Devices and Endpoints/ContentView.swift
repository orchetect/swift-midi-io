//
//  ContentView.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDIIO
import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var midiHelper: MIDIHelper

    @State private var devices: [MIDIDevice] = []
    @State private var inputEndpoints: [MIDIInputEndpoint] = []
    @State private var outputEndpoints: [MIDIOutputEndpoint] = []
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text(
                """
                This example displays the current list of devices and endpoints in the system.

                The `devicesStream()` and `endpointsStream()` methods return `AsyncSequence` which \
                produces a new result every time devices or endpoints change in the system.
                
                These sequences can be iterated over in a `Task` within SwiftUI views. \
                Local view state can then be updated as a result
                """
            )
            .multilineTextAlignment(.center)

            Form {
                Section("Devices") {
                    List(devices.sortedByName()) { device in
                        HStack {
                            (device.image.value ?? Image(systemName: "pianokeys.inverse"))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text(device.name)
                        }
                    }
                }

                Section("Input Endpoints") {
                    List(inputEndpoints.sortedByName()) { endpoint in
                        HStack {
                            (endpoint.image.value ?? Image(systemName: "pianokeys.inverse"))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text(endpoint.name)
                        }
                    }
                }

                Section("Output Endpoints") {
                    List(outputEndpoints.sortedByName()) { endpoint in
                        HStack {
                            (endpoint.image.value ?? Image(systemName: "pianokeys.inverse"))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text(endpoint.name)
                        }
                    }
                }
            }
            .formStyle(.grouped)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding()
        .task {
            // While the view is loaded, this sequence will receive new results any time the system changes.
            // The for-loop will automatically exit and Task will finish when the view disappears.
            for await devices in midiHelper.midiManager.devicesStream() {
                self.devices = devices.devices
            }
        }
        .task {
            // While the view is loaded, this sequence will receive new results any time the system changes.
            // The for-loop will automatically exit and Task will finish when the view disappears.
            for await endpoints in midiHelper.midiManager.endpointsStream() {
                inputEndpoints = endpoints.inputs
                outputEndpoints = endpoints.outputs
            }
        }
    }
}
