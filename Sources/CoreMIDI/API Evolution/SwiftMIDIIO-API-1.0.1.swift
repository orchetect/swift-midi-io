//
//  SwiftMIDIIO-API-1.0.1.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if !os(tvOS) && !os(watchOS)

import SwiftMIDICore

@_documentation(visibility: internal)
@available(
    *,
    deprecated,
    message: "ObservableObjectMIDIManager has been removed and its previously-observable properties have been replaced with `devicesStream()` and `endpointsStream()`"
)
public typealias ObservableObjectMIDIManager = MIDIManager

@_documentation(visibility: internal)
@available(
    *,
     deprecated,
     message: "ObservableMIDIManager has been removed and its previously-observable properties have been replaced with `devicesStream()` and `endpointsStream()`"
)
public typealias ObservableMIDIManager = MIDIManager

#endif
