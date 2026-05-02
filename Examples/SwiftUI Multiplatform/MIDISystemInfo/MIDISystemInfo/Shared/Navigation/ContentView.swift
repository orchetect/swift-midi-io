//
//  ContentView.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDIIO
import SwiftUI

struct ContentView<Details: DetailsContent>: View {
    @EnvironmentObject private var midiHelper: MIDIHelper
    @EnvironmentObject private var model: Model

    var body: some View {
        NavigationView {
            sidebar
            #if os(macOS)
                .frame(minWidth: 300)
            #endif

            EmptyDetailsView()
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var sidebar: some View {
        List {
            DeviceTreeView()
            OtherInputsView()
            OtherOutputsView()
        }
        #if os(macOS)
        .listStyle(.sidebar)
        #endif
    }
}
