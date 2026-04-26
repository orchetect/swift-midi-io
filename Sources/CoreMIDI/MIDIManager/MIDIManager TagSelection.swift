//
//  MIDIManager TagSelection.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if !os(tvOS) && !os(watchOS)

import Foundation

extension MIDIManager {
    /// Tag selection for managed input/connection operations.
    public enum TagSelection {
        case all
        case withTag(String)
    }
}

extension MIDIManager.TagSelection: Equatable { }

extension MIDIManager.TagSelection: Hashable { }

extension MIDIManager.TagSelection: Sendable { }

#endif
