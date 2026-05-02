//
//  MIDIManager Non-Started Tests.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if !os(tvOS) && !os(watchOS)

import CoreMIDI
import SwiftMIDIIO
import Testing

/// Tests to verify MIDIManager behavior when attempting to perform any actions without first starting the manager.
@Suite
struct MIDIManager_NonStarted_Tests {
    let manager = MIDIManager(
        clientName: UUID().uuidString,
        model: "SwiftMIDI123",
        manufacturer: "SwiftMIDI"
    )

    // iOS Simulator testing does not give enough permissions to allow creating virtual MIDI
    // ports, so skip these tests on iOS targets
    #if !targetEnvironment(simulator)
    @Test
    func addInput() {
        #expect(throws: MIDIIOError.managerNotStarted) {
            try manager.addInput(name: "Foo", tag: "Foo", uniqueID: .adHoc, receiver: .eventsLogging())
        }
        
        #expect(manager.managedInputs.isEmpty)
    }
    #endif
    
    // iOS Simulator testing does not give enough permissions to allow creating virtual MIDI
    // ports, so skip these tests on iOS targets
    #if !targetEnvironment(simulator)
    @Test
    func addOutput() {
        #expect(throws: MIDIIOError.managerNotStarted) {
            try manager.addOutput(name: "Foo", tag: "Foo", uniqueID: .adHoc)
        }
        
        #expect(manager.managedOutputs.isEmpty)
    }
    #endif
    
    @Test
    func addInputConnection() {
        #expect(throws: MIDIIOError.managerNotStarted) {
            try manager.addInputConnection(to: .allOutputs, tag: "Foo", receiver: .eventsLogging())
        }
        
        #expect(manager.managedInputConnections.isEmpty)
    }
    
    @Test
    func addOutputConnection() {
        #expect(throws: MIDIIOError.managerNotStarted) {
            try manager.addOutputConnection(to: .allInputs, tag: "Foo")
        }
        
        #expect(manager.managedOutputConnections.isEmpty)
    }
    
    @Test
    func nonPersistentThruConnection() {
        #expect(throws: MIDIIOError.managerNotStarted) {
            try manager.addThruConnection(
                outputs: [],
                inputs: [],
                tag: "Foo",
                lifecycle: .nonPersistent
            )
        }
        
        #expect(manager.managedThruConnections.isEmpty)
    }
    
    /// The `remove()` method is a non-throwing function, so it just silently returns if called prior to the manager being started.
    @Test
    func remove() {
        #expect(throws: Never.self) {
            try manager.remove(.input, .all)
        }
    }
}

#endif
