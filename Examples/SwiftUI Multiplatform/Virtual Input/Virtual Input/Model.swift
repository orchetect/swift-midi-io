//
//  Model.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftMIDICore

@MainActor @Observable
public final class Model {
    public internal(set) var receivedEventCount: Int = 0

    public init() { }

    public func handle(event: MIDIEvent) {
        receivedEventCount += 1

        print(event)
    }
}
