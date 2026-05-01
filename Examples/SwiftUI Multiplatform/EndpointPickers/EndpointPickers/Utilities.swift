//
//  Utilities.swift
//  SwiftMIDI Examples • https://github.com/orchetect/swift-midi-examples
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDIIO
import SwiftUI

/// Allow use with `@AppStorage` by conforming to a supported `RawRepresentable` type.
extension MIDIIdentifier: @retroactive RawRepresentable {
    public typealias RawValue = Int

    public init?(rawValue: RawValue) {
        self = Self(rawValue)
    }

    public var rawValue: RawValue {
        Int(self)
    }
}

extension UInt7 {
    public static func random() -> Self {
        UInt7(UInt.random(in: 0 ... 127))
    }

    public static func random(in range: ClosedRange<Self>) -> Self {
        let lb = UInt(range.lowerBound)
        let ub = UInt(range.upperBound)
        return UInt7(UInt.random(in: lb ... ub))
    }
}
