//
//  MIDIHelper.swift
//  SwiftMIDI Examples • https://github.com/orchetect/swift-midi-examples
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDIIO
import SwiftUI

/// Object responsible for managing MIDI services, managing connections, and sending/receiving events.
///
/// Marking the class as `@Observable` allows us to install an instance of the class in a SwiftUI App or View
/// and propagate it through the environment.
///
/// Properties that may result in UI changes are bound to `@MainActor` to ensure they are updated on the main thread.
@Observable
final class MIDIHelper: Sendable {
    let midiManager = MIDIManager(
        clientName: "TestAppMIDIManager",
        model: "TestApp",
        manufacturer: "MyCompany"
    )

    @MainActor private(set) var receivedEvents: [MIDIEvent] = []
    @MainActor var filterActiveSensingAndClock = true
    @MainActor private(set) var isVirtualEndpointsExist: Bool = false

    init(start: Bool = false) {
        if start { self.start() }
    }
}

// MARK: - Lifecycle

extension MIDIHelper {
    func start() {
        // update a local property in response to when
        // MIDI devices/endpoints change in system
        midiManager.notificationHandler = { [weak self] notification in
            switch notification {
            case .added, .removed, .propertyChanged:
                Task { @MainActor in self?.updateIsVirtualEndpointsExist() }
            default:
                break
            }
        }

        do {
            print("Starting MIDI services.")
            try midiManager.start()
        } catch {
            print("Error starting MIDI services:", error.localizedDescription)
        }

        do {
            try midiManager.addInputConnection(
                to: .none,
                tag: Tags.midiInConn,
                receiver: .events(options: [.bundleRPNAndNRPNDataEntryLSB]) { [weak self] events, timeStamp, source in
                    self?.received(events: events)
                }
            )

            try midiManager.addOutputConnection(
                to: .none,
                tag: Tags.midiOutConn
            )
        } catch {
            print("Error creating MIDI connections:", error.localizedDescription)
        }
    }
}

// MARK: - Common Event Receiver

extension MIDIHelper {
    private func received(events: [MIDIEvent]) {
        Task { @MainActor in
            let events = filterActiveSensingAndClock
                ? events.filter(sysRealTime: .dropTypes([.activeSensing, .timingClock]))
                : events

            // must update properties that result in UI changes on main thread
            self.receivedEvents.append(contentsOf: events)
        }
    }

    // MARK: - MIDI Input Connection

    var midiInputConnection: MIDIInputConnection? {
        midiManager.managedInputConnections[Tags.midiInConn]
    }

    // MARK: - MIDI Output Connection

    var midiOutputConnection: MIDIOutputConnection? {
        midiManager.managedOutputConnections[Tags.midiOutConn]
    }

    // MARK: - Test Virtual Endpoints

    var midiTestIn1: MIDIInput? {
        midiManager.managedInputs[Tags.midiTestIn1]
    }

    var midiTestIn2: MIDIInput? {
        midiManager.managedInputs[Tags.midiTestIn2]
    }

    var midiTestOut1: MIDIOutput? {
        midiManager.managedOutputs[Tags.midiTestOut1]
    }

    var midiTestOut2: MIDIOutput? {
        midiManager.managedOutputs[Tags.midiTestOut2]
    }

    func createVirtualEndpoints() {
        do {
            try midiManager.addInput(
                name: "Test In 1",
                tag: Tags.midiTestIn1,
                uniqueID: .userDefaultsManaged(key: Tags.midiTestIn1),
                receiver: .events(options: [.bundleRPNAndNRPNDataEntryLSB]) { [weak self] events, timeStamp, source in
                    self?.received(events: events)
                }
            )

            try midiManager.addInput(
                name: "Test In 2",
                tag: Tags.midiTestIn2,
                uniqueID: .userDefaultsManaged(key: Tags.midiTestIn2),
                receiver: .events(options: [.bundleRPNAndNRPNDataEntryLSB]) { [weak self] events, timeStamp, source in
                    self?.received(events: events)
                }
            )

            try midiManager.addOutput(
                name: "Test Out 1",
                tag: Tags.midiTestOut1,
                uniqueID: .userDefaultsManaged(key: Tags.midiTestOut1)
            )

            try midiManager.addOutput(
                name: "Test Out 2",
                tag: Tags.midiTestOut2,
                uniqueID: .userDefaultsManaged(key: Tags.midiTestOut2)
            )
        } catch {
            print(error.localizedDescription)
        }
    }

    func destroyVirtualInputs() {
        midiManager.remove(.input, .all)
        midiManager.remove(.output, .all)
    }

    @MainActor
    private func updateIsVirtualEndpointsExist() {
        isVirtualEndpointsExist = midiTestIn1 != nil
            && midiTestIn2 != nil
            && midiTestOut1 != nil
            && midiTestOut2 != nil
    }
}

// MARK: - Static

extension MIDIHelper {
    enum Tags {
        static let midiInConn = "SelectedInputConnection"
        static let midiOutConn = "SelectedOutputConnection"

        static let midiTestIn1 = "TestIn1"
        static let midiTestIn2 = "TestIn2"
        static let midiTestOut1 = "TestOut1"
        static let midiTestOut2 = "TestOut2"
    }

    enum PrefKeys {
        static let midiInID = "SelectedMIDIInID"
        static let midiInDisplayName = "SelectedMIDIInDisplayName"

        static let midiOutID = "SelectedMIDIOutID"
        static let midiOutDisplayName = "SelectedMIDIOutDisplayName"
    }

    enum Defaults {
        static let selectedDisplayName = "None"
    }
}
