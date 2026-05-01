//
//  MIDIEndpoint Properties Tests.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if !os(tvOS) && !os(watchOS)

import Foundation
@testable import SwiftMIDIIO
import Testing
import TestingExtensions

@Suite
struct MIDIEndpoint_Properties_Tests {
    static let clientName = UUID().uuidString
    
    let manager = MIDIManager(
        clientName: clientName,
        model: "SwiftMIDI123",
        manufacturer: "SwiftMIDI"
    )
    
    init() throws {
        try manager.start()
    }
    
    @Test
    func virtualInput_Properties() async throws {
        // add new endpoint
        
        let tag = UUID().uuidString
        
        try manager.addInput(
            name: tag,
            tag: tag,
            uniqueID: .adHoc, // allow system to generate random ID each time, no persistence
            receiver: .eventsLogging()
        )
        
        // wait for endpoint to appear
        try await wait(require: { manager.endpoints.inputs.contains(whereName: tag) }, timeout: 2.0)
        
        let endpoint = try #require(manager.endpoints.inputs.first(whereName: tag))
        
        // virtual endpoints never have a parent entity
        #expect(endpoint.entity == nil)
        
        // virtual endpoints never have a parent device
        #expect(endpoint.device == nil)
    }
    
    @Test
    func virtualOutput_Properties() async throws {
        // add new endpoint
        
        let tag = UUID().uuidString
        
        try manager.addOutput(
            name: tag,
            tag: tag,
            uniqueID: .adHoc // allow system to generate random ID each time, no persistence
        )
        
        // wait for endpoint to appear
        try await wait(require: { manager.endpoints.outputs.contains(whereName: tag) }, timeout: 2.0)
        
        let endpoint = try #require(manager.endpoints.outputs.first(whereName: tag))
        
        // virtual endpoints never have a parent entity
        #expect(endpoint.entity == nil)
        
        // virtual endpoints never have a parent device
        #expect(endpoint.device == nil)
    }
    
    /// This test does not inspect entities themselves, but simply performs the Core MIDI calls necessary to fetch them.
    /// This is a regression test to ensure that the internal methods do not cause a crash.
    @Test
    func probeEntities() async throws {
        let inputs = getSystemDestinationEndpoints()
        for input in inputs {
            _ = input.entity
        }
        
        let outputs = getSystemSourceEndpoints()
        for output in outputs {
            _ = output.entity
        }
    }
}

#endif
