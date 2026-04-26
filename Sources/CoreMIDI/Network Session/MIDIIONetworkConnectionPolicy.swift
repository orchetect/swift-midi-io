//
//  MIDIIONetworkConnectionPolicy.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import CoreMIDI
import Foundation

public enum MIDIIONetworkConnectionPolicy: UInt {
    case noOne
    case hostsInContactList
    case anyone
}

extension MIDIIONetworkConnectionPolicy: Equatable { }

extension MIDIIONetworkConnectionPolicy: Hashable { }

extension MIDIIONetworkConnectionPolicy: Sendable { }

// MARK: - Internal

extension MIDIIONetworkConnectionPolicy {
    init(_ coreMIDIPolicy: MIDINetworkConnectionPolicy) {
        switch coreMIDIPolicy {
        case .noOne:
            self = .noOne

        case .hostsInContactList:
            self = .hostsInContactList

        case .anyone:
            self = .anyone

        @unknown default:
            self = .noOne
        }
    }

    var coreMIDIPolicy: MIDINetworkConnectionPolicy {
        switch self {
        case .noOne:
            .noOne

        case .hostsInContactList:
            .hostsInContactList

        case .anyone:
            .anyone
        }
    }
}
