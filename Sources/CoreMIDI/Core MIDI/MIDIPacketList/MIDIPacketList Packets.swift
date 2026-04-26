//
//  MIDIPacketList Packets.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if !os(tvOS) && !os(watchOS)

import CoreMIDI
import Foundation
import SwiftMIDIInternals

extension UnsafePointer where Pointee == CoreMIDI.MIDIPacketList {
    /// Internal:
    /// Returns array of SwiftMIDI ``MIDIPacketData`` instances.
    func packets(
        refCon: UnsafeMutableRawPointer?,
        refConKnown: Bool
    ) -> [MIDIPacketData] {
        if pointee.numPackets == 0 {
            return []
        }

        // prefer newer Core MIDI API if platform supports it

        if #available(macOS 10.15, iOS 13.0, macCatalyst 13.0, *) {
            return unsafeSequence().map {
                MIDIPacketData($0, refCon: refCon, refConKnown: refConKnown)
            }
        } else {
            var packetDatas: [MIDIPacketData] = []
            pointee.packetPointerIterator {
                packetDatas.append(MIDIPacketData($0, refCon: refCon, refConKnown: refConKnown))
            }
            return packetDatas
        }
    }
}

#endif
