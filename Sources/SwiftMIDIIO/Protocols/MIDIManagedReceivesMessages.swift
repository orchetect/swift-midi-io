//
//  MIDIManagedReceivesMessages.swift
//  swift-midi • https://github.com/orchetect/swift-midi
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if !os(tvOS) && !os(watchOS)

/// ``MIDIManager`` object trait adopted by objects that receive MIDI messages.
public protocol MIDIManagedReceivesMessages: MIDIManaged {
    /// MIDI Protocol version used for this endpoint.
    /* public private(set) */ var midiProtocol: MIDIProtocolVersion { get }
}

#endif
