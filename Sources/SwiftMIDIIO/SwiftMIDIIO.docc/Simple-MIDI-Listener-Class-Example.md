# Simple MIDI Listener Class Example

A barebones example of how to set up SwiftMIDI to receive MIDI events on a created virtual input.

```swift
import Foundation
import SwiftMIDIIO

public class MIDIHelper {
    private let midiManager = MIDIManager(
        clientName: "MyApp",
        model: "MyApp",
        manufacturer: "MyCompany"
    )
    
    let inputTag = "Virtual_MIDI_In"

    public init() {
        do {
            try midiManager.start()
            
            try midiManager.addInput(
                name: "MyApp MIDI In",
                tag: inputTag,
                uniqueID: .userDefaultsManaged(key: inputTag),
                receiver: .events { [weak self] events, timeStamp, source in
                    // Note: this handler will be called on a background thread so be
                    // sure to call anything that may result in UI updates on the main thread
                    DispatchQueue.main.async {
                        events.forEach { self?.received(midiEvent: $0) }
                    }
                }
            )
        } catch {
            print("MIDI Setup Error:", error)
        }
    }
    
    private func received(midiEvent: MIDIEvent) {
        switch midiEvent {
        case let .noteOn(payload):
            print("Note On:", payload.note, payload.velocity, payload.channel)
        case let .noteOff(payload):
            print("Note Off:", payload.note, payload.velocity, payload.channel)
        case let .cc(payload):
            print("CC:", payload.controller, payload.value, payload.channel)
        case let .programChange(payload):
            print("Program Change:", payload.program, payload.channel)
            
        // etc...
            
        default:
            break
        }
    }
}
```
