//
//  Model.swift
//  SwiftMIDI Examples • https://github.com/orchetect/swift-midi-examples
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDICore

public final class Model: Sendable {
    public init() { }

    public func handle(event: MIDIEvent) {
        print(event)
    }
}
