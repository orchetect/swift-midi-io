//
//  MIDIEndpointMaskedFilter.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if !os(tvOS) && !os(watchOS)

public enum MIDIEndpointMaskedFilter {
    /// Filter by keeping only endpoints that match the filter.
    case only(MIDIEndpointFilter)

    /// Filter by dropping endpoints that match the filter and retaining all others.
    case drop(MIDIEndpointFilter)
}

extension MIDIEndpointMaskedFilter: Equatable { }

extension MIDIEndpointMaskedFilter: Hashable { }

extension MIDIEndpointMaskedFilter: Sendable { }

#endif
