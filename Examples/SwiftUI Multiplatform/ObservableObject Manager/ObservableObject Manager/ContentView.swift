//
//  ContentView.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDIIO
import SwiftUI

/// Note that `ObservableObject`-conforming classes must be installed in a SwiftUI view directly in order for state to update.
///
/// Which means you CANNOT observe nested `ObservableObject`s in a view. For example:
///     ```swift
///     @EnvironmentObject private var midiHelper: MIDIHelper
///
///     var body: some View {
///         List(midiHelper.midiManager.endpoints) { /* ... */ } // This WILL NOT auto-update.
///     }
///     ```
///
/// The `ObservableObjectMIDIManager` can be inserted into the environment, and then view state will update from it. For example:
///     ```swift
///     @EnvironmentObject private var midiManager: ObservableObjectMIDIManager
///
///     var body: some View {
///         List(midiManager.endpoints) { /* ... */ } // This WILL auto-update.
///     }
///     ```
struct ContentView: View {
    @EnvironmentObject private var midiHelper: MIDIHelper
    @EnvironmentObject private var midiManager: ObservableObjectMIDIManager

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
                    List(midiManager.devices.devices.sortedByName()) { device in
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
                    List(midiManager.endpoints.inputs.sortedByName()) { endpoint in
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
                    List(midiManager.endpoints.outputs.sortedByName()) { endpoint in
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
