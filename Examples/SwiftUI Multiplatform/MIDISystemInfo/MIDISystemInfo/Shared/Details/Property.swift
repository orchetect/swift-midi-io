//
//  Property.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDIIO
import SwiftUI

struct Property: Hashable {
    let key: String
    let value: String
    let status: Status?
}

extension Property: Identifiable {
    var id: String {
        key
    }
}

extension Property {
    var color: Color {
        status?.color ?? .secondary
    }
}

// MARK: - Status

extension Property {
    enum Status {
        case error
        case notSet
    }
}

extension Property.Status {
    var color: Color {
        switch self {
        case .error: .red
        case .notSet: .yellow
        }
    }

    @ViewBuilder
    var view: some View {
        switch self {
        case .error:
            if let warningSymbol {
                warningSymbol
            } else {
                Text("⚠️")
            }
        case .notSet:
            if let tagSlashSymbol {
                tagSlashSymbol
            } else {
                Text("🏷️") // 🏷️❔💬🚫❌
            }
        }
    }

    private var warningSymbol: (some View)? {
        if #available(macOS 11.0, iOS 13.0, *) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(color)
        } else {
            nil
        }
    }

    private var tagSlashSymbol: (some View)? {
        if #available(macOS 11.0, iOS 13.0, *) {
            Image(systemName: "tag.slash.fill")
                .foregroundColor(color)
        } else {
            nil
        }
    }
}
