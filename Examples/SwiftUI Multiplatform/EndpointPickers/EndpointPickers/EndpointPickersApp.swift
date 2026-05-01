//
//  EndpointPickersApp.swift
//  SwiftMIDI Examples • https://github.com/orchetect/swift-midi-examples
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Combine
import SwiftMIDIIO
import SwiftUI

@main
struct EndpointPickersApp: App {
    @State var midiHelper = MIDIHelper(start: true)

    @AppStorage(MIDIHelper.PrefKeys.midiInID) var midiInSelectedID: MIDIIdentifier?
    @AppStorage(MIDIHelper.PrefKeys.midiInDisplayName) var midiInSelectedDisplayName: String?
    @AppStorage(MIDIHelper.PrefKeys.midiOutID) var midiOutSelectedID: MIDIIdentifier?
    @AppStorage(MIDIHelper.PrefKeys.midiOutDisplayName) var midiOutSelectedDisplayName: String?

    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    try? await Task.sleep(for: .seconds(1))
                    updateConnections()
                }
        }
        .environment(midiHelper)
    }
    
    /// Provide the MIDI connections with persistently-stored endpoint information in order to reconnect them on initial view load.
    /// The endpoints don't need to exist in the system at the time of adding them to the connections.
    /// The MIDI Manager will automatically reconnect to the endpoints when the endpoints reappear in the system.
    private func updateConnections() {
        if let midiInSelectedID, let midiInSelectedDisplayName {
            midiHelper.midiInputConnection?.add(outputs: [
                .uniqueIDWithFallback(id: midiInSelectedID, fallbackDisplayName: midiInSelectedDisplayName)
            ])
        }
        if let midiOutSelectedID, let midiOutSelectedDisplayName {
            midiHelper.midiOutputConnection?.add(inputs: [
                .uniqueIDWithFallback(id: midiOutSelectedID, fallbackDisplayName: midiOutSelectedDisplayName)
            ])
        }
    }
}
