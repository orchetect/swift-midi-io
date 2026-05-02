//
//  BTMIDICentralViewController.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(iOS) || os(visionOS)

import CoreAudioKit
import UIKit

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
