//
//  BluetoothMIDIPeripheralView.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(iOS)

import CoreAudioKit
import SwiftUI
import UIKit

struct BluetoothMIDIPeripheralView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> BTMIDIPeripheralViewController {
        BTMIDIPeripheralViewController()
    }

    func updateUIViewController(
        _ uiViewController: BTMIDIPeripheralViewController,
        context: Context
    ) { }

    typealias UIViewControllerType = BTMIDIPeripheralViewController
}

class BTMIDIPeripheralViewController: CABTMIDILocalPeripheralViewController {
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
