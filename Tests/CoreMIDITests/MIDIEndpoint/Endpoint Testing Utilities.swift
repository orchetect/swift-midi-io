//
//  Endpoint Testing Utilities.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if !os(tvOS) && !os(watchOS)

@testable import SwiftMIDIIO

extension MIDIInputEndpoint {
    /// Unit testing only:
    /// Manually mock an endpoint with custom name, display name, and unique ID.
    init(
        ref: CoreMIDIEndpointRef,
        name: String,
        displayName: String,
        uniqueID: MIDIIdentifier
    ) {
        self.init(from: ref)
        self.name = name
        self.displayName = displayName
        self.uniqueID = uniqueID
    }
}

extension MIDIOutputEndpoint {
    /// Unit testing only:
    /// Manually mock an endpoint with custom name, display name, and unique ID.
    init(
        ref: CoreMIDIEndpointRef,
        name: String,
        displayName: String,
        uniqueID: MIDIIdentifier
    ) {
        self.init(from: ref)
        self.name = name
        self.displayName = displayName
        self.uniqueID = uniqueID
    }
}

#endif
