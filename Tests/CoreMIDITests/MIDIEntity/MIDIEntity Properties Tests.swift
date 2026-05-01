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
    static let clientName = UUID().uuidString
    
    let manager = MIDIManager(
        clientName: clientName,
        model: "SwiftMIDI123",
        manufacturer: "SwiftMIDI"
    )
    
    init() throws {
        try manager.start()
    }
    
    // TODO: Add test checking `device` property if possible
}

#endif
