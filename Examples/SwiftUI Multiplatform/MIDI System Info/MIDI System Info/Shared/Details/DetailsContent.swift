//
//  DetailsContent.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDIIO
import SwiftUI

protocol DetailsContent where Self: View {
    init(object: AnyMIDIIOObject)
}
