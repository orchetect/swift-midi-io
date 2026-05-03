//
//  ObservableManagerApp.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftUI

@main
struct ObservableManagerApp: App {
    @State var midiHelper = MIDIHelper(start: true)

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environment(midiHelper)
        #if os(macOS)
        .defaultSize(width: 600, height: 800)
        #endif
    }
}
