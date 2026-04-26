//
//  AnyMIDIPacketData+CoreMIDI.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if !os(tvOS) && !os(watchOS)

import CoreMIDI
import SwiftMIDICore

/// Type-erased box that can hold any CoreMIDI MIDI packet data on Apple platforms.
public typealias AnyMIDIPacketData = SwiftMIDICore.AnyMIDIPacketData<CoreMIDITimeStamp, MIDIOutputEndpoint>

#endif
