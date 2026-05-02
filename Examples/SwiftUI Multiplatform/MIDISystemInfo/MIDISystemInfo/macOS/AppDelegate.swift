//
//  AppDelegate.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDIIO
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    static let midiHelper = MIDIHelper(start: true)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the window and set the content view.
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 950, height: 850),
            styleMask: [
                .titled,
                .unifiedTitleAndToolbar,
                .fullSizeContentView,
                .miniaturizable,
                .resizable
            ],
            backing: .buffered,
            defer: false
        )

        // Create the SwiftUI view that provides the window contents.
        window.isReleasedWhenClosed = false

        window.center()
        window.setFrameAutosaveName("Main Window")

        window.title = "MIDI System Info"
        if #available(macOS 11.0, *) {
            window.toolbarStyle = .unified

            // force window to take on a unified title/toolbar look in the absence of toolbar content
            window.toolbar = .init()
        }

        window.contentView = NSHostingView(
            rootView: ContentViewForCurrentPlatform()
                .environmentObject(Self.midiHelper)
        )

        window.makeKeyAndOrderFront(nil)
    }
}
