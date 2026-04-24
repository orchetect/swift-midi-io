//
//  UniversalMIDIPacketData+CoreMIDI.swift
//  swift-midi • https://github.com/orchetect/swift-midi
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if !os(tvOS) && !os(watchOS)

import CoreMIDI
import SwiftMIDIInternals

@available(macOS 11, iOS 14, macCatalyst 14, *)
extension UniversalMIDIPacketData where TimeStamp == CoreMIDITimeStamp, OutputEndpoint == MIDIOutputEndpoint {
    /// Universal MIDI Packet.
    init(
        _ eventPacketPtr: UnsafePointer<MIDIEventPacket>,
        refCon: UnsafeMutableRawPointer?,
        refConKnown: Bool
    ) {
        self = Self.unwrapPacket(eventPacketPtr, refCon: refCon, refConKnown: refConKnown)
    }
    
    /// Universal MIDI Packet.
    init(
        _ eventPacket: MIDIEventPacket,
        refCon: UnsafeMutableRawPointer?,
        refConKnown: Bool
    ) {
        self = Self.packetUnwrapper(eventPacket, refCon: refCon, refConKnown: refConKnown)
    }
    
    fileprivate static func unwrapPacket(
        _ eventPacketPtr: UnsafePointer<MIDIEventPacket>,
        refCon: UnsafeMutableRawPointer?,
        refConKnown: Bool
    ) -> UniversalMIDIPacketData {
        UniversalMIDIPacketData(
            words: eventPacketPtr.rawWords,
            timeStamp: eventPacketPtr.pointee.timeStamp,
            source: unpackMIDIRefCon(refCon: refCon, known: refConKnown)
        )
    }
    
    fileprivate static func packetUnwrapper(
        _ eventPacket: MIDIEventPacket,
        refCon: UnsafeMutableRawPointer?,
        refConKnown: Bool
    ) -> UniversalMIDIPacketData {
        UniversalMIDIPacketData(
            words: eventPacket.rawWords,
            timeStamp: eventPacket.timeStamp,
            source: unpackMIDIRefCon(refCon: refCon, known: refConKnown)
        )
    }
}

#endif
