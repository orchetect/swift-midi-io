//
//  DetailsView.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDIIO
import SwiftUI

extension ContentView {
    struct DetailsView: View {
        @EnvironmentObject private var model: Model
        
        var object: AnyMIDIIOObject

        var body: some View {
            if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
                conditionalToolbarBody
                    .searchable(text: $model.searchText, placement: .toolbar, prompt: "Search")
            } else {
                conditionalToolbarBody
            }
        }
        
        @ViewBuilder
        var conditionalToolbarBody: some View {
            if #available(macOS 11.0, iOS 14.0, *) {
                detailsBody
                    .toolbar {
                        ToolbarItem(placement: .primaryAction) {
                            Toggle(isOn: $model.isOnlySetPropertiesShown.animation(.default)) {
                                Label("Show Set Only", systemImage: filterImageName)
                            }
                            .help("Show Set Properties Only")
                        }
                    }
            } else {
                detailsBody
            }
        }

        private var filterImageName: String {
            #if os(macOS)
            return model.isOnlySetPropertiesShown
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
                Details(object: object)

                // only show the toggle if it's not already present in the toolbar
                if #available(macOS 11.0, iOS 14.0, *) {
                    EmptyView()
                } else {
                    Toggle("Show Set Properties Only", isOn: $model.isOnlySetPropertiesShown.animation(.default))
                        .padding()
                        .toggleStyle(.switch)
                }
            }
        }
    }
}
