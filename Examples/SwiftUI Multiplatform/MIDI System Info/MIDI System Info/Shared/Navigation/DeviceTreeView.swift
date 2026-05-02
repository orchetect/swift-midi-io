//
//  DeviceTreeView.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Combine
import SwiftMIDIIO
import SwiftUI

extension ContentView {
    struct DeviceTreeView: View {
        @EnvironmentObject private var midiHelper: MIDIHelper
        @EnvironmentObject private var model: Model

        var body: some View {
            Section(header: Text("Device Tree")) {
                if model.treeItems.isEmpty {
                    Text("None")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(model.treeItems) { item in
                        navLink(item: item)
                    }
                }
            }
            .onAppear {
                model.updateTreeItems(devices: midiHelper.devices?.devices ?? [])
            }
            .onChange(of: midiHelper.devices) { devices in
                model.updateTreeItems(devices: devices?.devices ?? [])
            }
        }

        private func navLink(item: AnyMIDIIOObject) -> some View {
            NavigationLink(destination: detailsView(item: item)) {
                HStack {
                    switch item.objectType {
                    case .device:
                        EmptyView()

                    case .entity:
                        Spacer()
                            .frame(width: 24, height: 18, alignment: .center)

                    case .inputEndpoint, .outputEndpoint:
                        Spacer()
                            .frame(width: 48, height: 18, alignment: .center)
                    }

                    ItemIcon(item: item, default: Text("🎹"))

                    Text(item.name)

                    Spacer()

                    Group {
                        switch item.objectType {
                        case .inputEndpoint: Text("In")
                        case .outputEndpoint: Text("Out")
                        default: EmptyView()
                        }
                    }
                    .foregroundColor(.secondary)
                }
            }
        }

        private func detailsView(item: AnyMIDIIOObject) -> some View {
            DetailsView(object: item.asAnyMIDIIOObject())
        }
    }
}
