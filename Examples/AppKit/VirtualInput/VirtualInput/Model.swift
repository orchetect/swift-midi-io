//
//  Model.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDICore

public final class Model: Sendable {
    public init() { }

    public func handle(event: MIDIEvent) {
        print(event)
    }
}
