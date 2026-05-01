//
//  MIDIHelper.swift
//  SwiftMIDI Examples • https://github.com/orchetect/swift-midi-examples
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftMIDIIO

/// Object responsible for managing MIDI services, managing connections, and sending/receiving events.
public final class MIDIHelper: Sendable {
    private let midiManager = MIDIManager(
        clientName: "TestAppMIDIManager",
        model: "TestApp",
        manufacturer: "MyCompany"
    )

    public init(start: Bool = false) {
        if start { self.start() }
    }
}

// MARK: - Static

extension MIDIHelper {
    public var virtualOutputName: String {
        "TestApp Output"
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

        createOutput()
    }

    public func stop() {
        removeOutput()
    }
}

// MARK: - I/O

extension MIDIHelper {
    public var virtualOutput: MIDIOutput? {
        midiManager.managedOutputs[virtualOutputName]
    }

    private func createOutput() {
        do {
            print("Creating virtual MIDI output.")
            try midiManager.addOutput(
                name: virtualOutputName,
                tag: virtualOutputName,
                uniqueID: .userDefaultsManaged(key: virtualOutputName)
            )
        } catch {
            print("Error creating virtual MIDI output:", error.localizedDescription)
        }
    }

    private func removeOutput() {
        midiManager.remove(.output, .withTag(virtualOutputName))
    }
}
