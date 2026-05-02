//
//  ContentView.swift
//  SwiftMIDI Examples • https://github.com/orchetect/swift-midi-examples
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDIIO
import SwiftUI

/// Dynamically uses modern UI elements when the platform supports it.
struct ContentViewForCurrentPlatform: View {
    @State private var showRelevantProperties: Bool = true

    var body: some View {
        if #available(macOS 12, iOS 16, *) {
            if #available(macOS 13, *) {
                ContentView<FormDetailsView>(showRelevantProperties: $showRelevantProperties)
            } else {
                ContentView<TableDetailsView>(showRelevantProperties: $showRelevantProperties)
            }
        } else {
            ContentView<LegacyDetailsView>(showRelevantProperties: $showRelevantProperties)
        }
    }
}

struct ContentView<Details: DetailsContent>: View {
    @EnvironmentObject private var midiHelper: MIDIHelper

    @Binding var showRelevantProperties: Bool

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
            DeviceTreeView(showRelevantProperties: $showRelevantProperties)
            OtherInputsView(showRelevantProperties: $showRelevantProperties)
            OtherOutputsView(showRelevantProperties: $showRelevantProperties)
        }
        #if os(macOS)
        .listStyle(.sidebar)
        #endif
    }
}

#if DEBUG
struct ContentViewPreviews: PreviewProvider {
    static let midiHelper = MIDIHelper(start: true)

    static var previews: some View {
        ContentViewForCurrentPlatform()
            .environmentObject(midiHelper)
    }
}
#endif
