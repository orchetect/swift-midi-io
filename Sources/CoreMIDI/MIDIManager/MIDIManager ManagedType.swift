//
//  MIDIManager ManagedType.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if !os(tvOS) && !os(watchOS)

import Foundation

extension MIDIManager {
    /// Managed port or connection type.
    public enum ManagedType {
        case inputConnection
        case outputConnection
        case input
        case output
        case nonPersistentThruConnection
    }
}

extension MIDIManager.ManagedType: Equatable { }

extension MIDIManager.ManagedType: Hashable { }

extension MIDIManager.ManagedType: CaseIterable { }

extension MIDIManager.ManagedType: Sendable { }

#endif
