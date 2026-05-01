//
//  MIDIEntity Properties Tests.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if !os(tvOS) && !os(watchOS)

import Foundation
@testable import SwiftMIDIIO
import Testing
import TestingExtensions

@Suite
struct MIDIEntity_Properties_Tests {
    /// This test does not inspect devices themselves, but simply performs the Core MIDI calls necessary to fetch them.
    /// This is a regression test to ensure that the internal methods do not cause a crash.
    @Test
    func probeDevices() async throws {
        let inputs = getSystemDestinationEndpoints()
        for input in inputs {
            _ = input.device
        }
        
        let outputs = getSystemSourceEndpoints()
        for output in outputs {
            _ = output.device
        }
    }
    
    // TODO: Add test checking `device` property for endpoints that are known to have devices, if possible (can't use virtual endpoints)
}

#endif
