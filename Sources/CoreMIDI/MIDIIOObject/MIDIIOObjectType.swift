//
//  MIDIIOObjectType.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if !os(tvOS) && !os(watchOS)

import Foundation

/// Describes the type of a ``MIDIIOObject`` instance.
public enum MIDIIOObjectType {
    case device
    case entity
    case inputEndpoint
    case outputEndpoint
}

extension MIDIIOObjectType: Equatable { }

extension MIDIIOObjectType: Hashable { }

extension MIDIIOObjectType: CaseIterable { }

extension MIDIIOObjectType: Sendable { }

// MARK: - Properties

extension MIDIIOObjectType {
    /// Internal: returns relevant `MIDIIOObject.Property`s associated with the object type.
    var relevantProperties: [MIDIIOObjectProperty] {
        MIDIIOObjectProperty.allCases.filter {
            $0.relevantObjects.contains(self)
        }
    }
}

#endif
