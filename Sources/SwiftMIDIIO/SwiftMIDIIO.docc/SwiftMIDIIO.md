# ``SwiftMIDIIO``

Core MIDI I/O wrapper layer offering ``MIDIManager`` class to create virtual ports and connect to existing ports in the system in order to send and receive MIDI events.

![SwiftMIDI](swiftmidi-banner.png)

![Layer Diagram](swiftmidiio-diagram.svg)

SwiftMIDIIO adds an I/O layer on top of SwiftMIDICore's MIDI events, providing the essentials to send and receive MIDI events on Apple platforms.

To add additional functionality, import extension modules or import the SwiftMIDI umbrella library which imports all of SwiftMIDI events, I/O, and extensions.

## Topics

### Manager

- ``MIDIManager``
- ``ObservableMIDIManager``
- ``ObservableObjectMIDIManager``
- <doc:MIDIManager-Creating-Ports>
- <doc:MIDIManager-Creating-Connections>
- <doc:MIDIManager-Removing-Ports-and-Connections>
- <doc:MIDIManager-Receiving-Notifications>
- <doc:SwiftMIDIIO-SwiftUI-and-Combine-Features>

### Devices & Entities

- <doc:SwiftMIDIIO-Devices>

### Endpoints

- <doc:SwiftMIDIIO-Endpoints>

### Events

- <doc:SwiftMIDIIO-Sending-MIDI-Events>
- <doc:SwiftMIDIIO-Receiving-MIDI-Events>

### Extending Connectivity

- <doc:SwiftMIDIIO-MIDI-Over-Bluetooth>
- <doc:SwiftMIDIIO-MIDI-Over-Network>
- <doc:SwiftMIDIIO-MIDI-Over-USB>

### Additional Topics

- <doc:Send-and-Receive-on-iOS-in-Background>
- <doc:MIDI-Show-Control>
- <doc:Simple-MIDI-Listener-Class-Example>

### Internals

- <doc:SwiftMIDIIO-Internals>
