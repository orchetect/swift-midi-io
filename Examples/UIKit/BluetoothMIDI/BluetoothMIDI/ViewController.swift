//
//  ViewController.swift
//  SwiftMIDI Examples • https://github.com/orchetect/swift-midi-examples
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDIIO
import UIKit

class ViewController: UIViewController {
    var appDelegate: AppDelegate? {
        UIApplication.shared.delegate as? AppDelegate
    }

    var outputConnection: MIDIOutputConnection? {
        appDelegate?.midiHelper.outputConnection
    }

    @IBAction
    func showBluetoothMIDIRemoteSetup(_ sender: Any) {
        let sheetViewController = BTMIDICentralViewController(nibName: nil, bundle: nil)
        present(sheetViewController, animated: true, completion: nil)
    }

    @IBAction
    func showBluetoothMIDILocalSetup(_ sender: Any) {
        let sheetViewController = BTMIDIPeripheralViewController(nibName: nil, bundle: nil)
        present(sheetViewController, animated: true, completion: nil)
    }

    @IBAction
    func sendTestMIDIEvent(_ sender: Any) {
        try? outputConnection?.send(event: .cc(.expression, value: .midi1(64), channel: 0))
    }
}
