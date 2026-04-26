//
//  TestActor.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

/// Dedicated serial actor for objects used in unit tests.
@globalActor
actor TestActor {
    static let shared = TestActor()
}
