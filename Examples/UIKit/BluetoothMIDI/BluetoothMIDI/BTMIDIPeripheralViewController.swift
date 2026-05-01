//
//  BTMIDIPeripheralViewController.swift
//  SwiftMIDI Examples • https://github.com/orchetect/swift-midi-examples
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(iOS) || os(visionOS)

import CoreAudioKit
import UIKit

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
