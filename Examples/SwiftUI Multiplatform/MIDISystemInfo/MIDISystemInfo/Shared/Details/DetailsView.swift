//
//  DetailsView.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDIIO
import SwiftUI

extension ContentView {
    struct DetailsView: View {
        var object: AnyMIDIIOObject
        @Binding var isRelevantPropertiesOnlyShown: Bool

        var body: some View {
            if #available(macOS 11.0, iOS 14.0, *) {
                detailsBody
                    .toolbar {
                        Toggle(isOn: $isRelevantPropertiesOnlyShown.animation(.default)) {
                            Label("Relevant Only", systemImage: filterImageName)
                        }
                        .help("Show Only Relevant Properties")
                    }
            } else {
                detailsBody
            }
        }

        private var filterImageName: String {
            #if os(macOS)
            return isRelevantPropertiesOnlyShown
                ? "line.3.horizontal.decrease.circle.fill"
                : "line.3.horizontal.decrease.circle"
            #else
            if #available(iOS 26.0, *) {
                return "line.3.horizontal.decrease"
            } else {
                return "line.3.horizontal.decrease.circle"
            }
            #endif
        }

        private var detailsBody: some View {
            VStack(alignment: .leading) {
                Details(object: object, isRelevantPropertiesOnlyShown: $isRelevantPropertiesOnlyShown)

                // only show the toggle if it's not already present in the toolbar
                if #available(macOS 11.0, iOS 14.0, *) {
                    EmptyView()
                } else {
                    Toggle("Relevant Only", isOn: $isRelevantPropertiesOnlyShown.animation(.default))
                        .padding()
                        .toggleStyle(.switch)
                }
            }
        }
    }
}
