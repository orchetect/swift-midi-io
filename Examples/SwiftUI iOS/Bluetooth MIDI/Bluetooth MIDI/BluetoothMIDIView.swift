//
//  BluetoothMIDIView.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(iOS)

import CoreAudioKit
import SwiftUI
import UIKit

struct BluetoothMIDIView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> BTMIDICentralViewController {
        BTMIDICentralViewController()
    }

    func updateUIViewController(
        _ uiViewController: BTMIDICentralViewController,
        context: Context
    ) { }

    typealias UIViewControllerType = BTMIDICentralViewController
}

class BTMIDICentralViewController: CABTMIDICentralViewController {
    var uiViewController: UIViewController?

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneAction)
        )
    }

    @objc
    func doneAction() {
        uiViewController?.dismiss(animated: true, completion: nil)
    }
}

#endif
