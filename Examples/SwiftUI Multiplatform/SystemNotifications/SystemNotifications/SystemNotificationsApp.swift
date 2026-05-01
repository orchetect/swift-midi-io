//
//  SystemNotificationsApp.swift
//  SwiftMIDI Examples • https://github.com/orchetect/swift-midi-examples
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftUI

@main
struct SystemNotificationsApp: App {
    @State private var midiHelper = MIDIHelper(start: true)

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environment(midiHelper)
    }
}
