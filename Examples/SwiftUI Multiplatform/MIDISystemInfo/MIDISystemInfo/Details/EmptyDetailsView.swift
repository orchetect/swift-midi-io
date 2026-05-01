//
//  EmptyDetailsView.swift
//  SwiftMIDI Examples • https://github.com/orchetect/swift-midi-examples
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftUI

struct EmptyDetailsView: View {
    var body: some View {
        VStack {
            if #available(macOS 11.0, iOS 14.0, *) {
                Image(systemName: "pianokeys")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.secondary)
                    .frame(width: 140, height: 140)
                Spacer()
                    .frame(height: 50)
            }

            Text("Make a selection from the sidebar.")
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
