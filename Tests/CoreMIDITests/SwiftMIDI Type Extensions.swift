//
//  SwiftMIDI Type Extensions.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if !os(tvOS) && !os(watchOS)

import SwiftMIDIIO

extension MIDIIONotification {
    enum Kind: Equatable, Hashable, Sendable, CaseIterable {
        case setupChanged
        case added
        case removed
        case propertyChanged
        case thruConnectionChanged
        case serialPortOwnerChanged
        case ioError
        case internalStart
        case other
    }

    func isCase(_ kind: Kind) -> Bool {
        switch (self, kind) {
        case (.setupChanged, .setupChanged): true
        case (.added, .added): true
        case (.removed, .removed): true
        case (.propertyChanged, .propertyChanged): true
        case (.thruConnectionChanged, .thruConnectionChanged): true
        case (.serialPortOwnerChanged, .serialPortOwnerChanged): true
        case (.ioError, .ioError): true
        case (.internalStart, .internalStart): true
        case (.other, .other): true
        default: false
        }
    }
}

#endif
