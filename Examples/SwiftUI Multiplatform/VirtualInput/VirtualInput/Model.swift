//
//  Model.swift
//  SwiftMIDI Examples • https://github.com/orchetect/swift-midi-examples
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
