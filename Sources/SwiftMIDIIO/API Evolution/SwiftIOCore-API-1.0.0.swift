//
//  SwiftMIDICore-API-1.0.0.swift
//  swift-midi • https://github.com/orchetect/swift-midi
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDICore

@_documentation(visibility: internal)
@available(*, deprecated, renamed: "AnyMIDIPacketData")
public typealias AnyMIDIPacket = AnyMIDIPacketData<CoreMIDITimeStamp, MIDIOutputEndpoint>
