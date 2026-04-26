//
//  Core MIDI Ref Types.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

/// SwiftMIDI analogue for Core MIDI's `MIDIObjectRef`.
public typealias CoreMIDIObjectRef = UInt32

/// SwiftMIDI analogue for Core MIDI's `MIDIClientRef`.
public typealias CoreMIDIClientRef = CoreMIDIObjectRef

/// SwiftMIDI analogue for Core MIDI's `MIDIDeviceRef`.
public typealias CoreMIDIDeviceRef = CoreMIDIObjectRef

/// SwiftMIDI analogue for Core MIDI's `MIDIEntityRef`.
public typealias CoreMIDIEntityRef = CoreMIDIObjectRef

/// SwiftMIDI analogue for Core MIDI's `MIDIPortRef`.
public typealias CoreMIDIPortRef = CoreMIDIObjectRef

/// SwiftMIDI analogue for Core MIDI's `MIDIEndpointRef`.
public typealias CoreMIDIEndpointRef = CoreMIDIObjectRef

/// SwiftMIDI analogue for Core MIDI's `MIDIThruConnectionRef`.
public typealias CoreMIDIThruConnectionRef = CoreMIDIObjectRef

/// SwiftMIDI analogue for Core MIDI's `MIDITimeStamp`.
public typealias CoreMIDITimeStamp = UInt64

/// SwiftMIDI analogue for Core MIDI's `OSStatus`.
public typealias CoreMIDIOSStatus = Int32
