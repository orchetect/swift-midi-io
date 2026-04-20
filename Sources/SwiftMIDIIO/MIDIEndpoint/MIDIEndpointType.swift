//
//  MIDIEndpointType.swift
//  swift-midi • https://github.com/orchetect/swift-midi
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if !os(tvOS) && !os(watchOS)

/// The specialized type of a MIDI endpoint (input/output).
public enum MIDIEndpointType {
    case input
    case output
}

extension MIDIEndpointType: Equatable { }

extension MIDIEndpointType: Hashable { }

extension MIDIEndpointType: CaseIterable { }

extension MIDIEndpointType: Sendable { }

#endif
