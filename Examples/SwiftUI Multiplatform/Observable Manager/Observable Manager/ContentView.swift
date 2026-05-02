//
//  ContentView.swift
//  SwiftMIDI Examples • https://github.com/orchetect/swift-midi-examples
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftUI

struct ContentView: View {
    @Environment(MIDIHelper.self) private var midiHelper

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text(
                """
                This example displays the current list of devices and endpoints in the system.
                
                The devices and endpoints properties are observable in SwiftUI views, which means \
                view state will automatically update when there are changes to devices or endpoints in the system.
                """
            )
            .multilineTextAlignment(.center)

            Form {
                Section("Devices") {
                    List(midiHelper.midiManager.devices.devices.sortedByName()) { device in
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
                    List(midiHelper.midiManager.endpoints.inputs.sortedByName()) { endpoint in
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
                    List(midiHelper.midiManager.endpoints.outputs.sortedByName()) { endpoint in
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
    }
}
