//
//  MIDI1Parser+CoreMIDI.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if !os(tvOS) && !os(watchOS)

import CoreMIDI
import SwiftMIDICore

/// Wrapper for MIDI 2.0 event parser that adds certain heuristics, including RPN/NRPN bundling on Apple platforms.
public typealias AdvancedMIDI2Parser = SwiftMIDICore.AdvancedMIDI2Parser<CoreMIDITimeStamp, MIDIOutputEndpoint>

#endif
