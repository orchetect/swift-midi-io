//
//  MIDIHelper.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDIIO
import SwiftUI
import Synchronization

/// Object responsible for managing MIDI services, managing connections, and sending/receiving events.
///
/// Conforming the class to `ObservableObject` allows us to install an instance of the class in a SwiftUI App or View
/// and propagate it through the environment.
public final class MIDIHelper: ObservableObject, Sendable {
    let midiManager = MIDIManager(
        clientName: "TestAppMIDIManager",
        model: "TestApp",
        manufacturer: "MyCompany"
    )

    public init(start: Bool = false) {
        if start { self.start() }
    }
}

// MARK: - Lifecycle

extension MIDIHelper {
    public func start() {
        do {
            print("Starting MIDI services.")
            try midiManager.start()
        } catch {
            print("Error starting MIDI services:", error.localizedDescription)
        }
    }
}
