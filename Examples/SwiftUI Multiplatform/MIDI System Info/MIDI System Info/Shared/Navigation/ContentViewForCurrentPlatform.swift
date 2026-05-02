//
//  ContentViewForCurrentPlatform.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDIIO
import SwiftUI

/// Dynamically uses modern UI elements when the platform supports it.
struct ContentViewForCurrentPlatform: View {
    @EnvironmentObject private var model: Model
    
    var body: some View {
        if #available(macOS 12, iOS 16, *) {
            if #available(macOS 13, *) {
                ContentView<FormDetailsView>()
            } else {
                ContentView<TableDetailsView>()
            }
        } else {
            ContentView<LegacyDetailsView>()
        }
    }
}

#if DEBUG
struct ContentViewForCurrentPlatformPreviews: PreviewProvider {
    static let midiHelper = MIDIHelper(start: true)

    static var previews: some View {
        ContentViewForCurrentPlatform()
            .environmentObject(midiHelper)
    }
}
#endif
