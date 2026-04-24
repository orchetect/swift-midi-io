//
//  MIDIPacketData+CoreMIDI.swift
//  swift-midi • https://github.com/orchetect/swift-midi
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if !os(tvOS) && !os(watchOS)

import CoreMIDI
import SwiftMIDICore

/// MIDI 1.0 packet data for use with CoreMIDI on Apple platforms.
public typealias MIDIPacketData = SwiftMIDICore.MIDIPacketData<CoreMIDITimeStamp, MIDIOutputEndpoint>

extension MIDIPacketData {
    init(
        _ midiPacketPtr: UnsafePointer<MIDIPacket>,
        refCon: UnsafeMutableRawPointer?,
        refConKnown: Bool
    ) {
        self = Self.unwrapPacket(midiPacketPtr, refCon: refCon, refConKnown: refConKnown)
    }
    
    fileprivate static func unwrapPacket(
        _ midiPacketPtr: UnsafePointer<MIDIPacket>,
        refCon: UnsafeMutableRawPointer?,
        refConKnown: Bool
    ) -> MIDIPacketData {
        MIDIPacketData(
            bytes: midiPacketPtr.rawBytes,
            timeStamp: midiPacketPtr.rawTimeStamp,
            source: unpackMIDIRefCon(refCon: refCon, known: refConKnown)
        )
    }
}

#endif
