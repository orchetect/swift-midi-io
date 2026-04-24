# ``SwiftMIDIIO``

CoreMIDI I/O wrapper layer offering ``MIDIManager`` class to create virtual ports and connect to existing ports in the system in order to send and receive MIDI events.

![swift-midi-io](swift-midi-io-banner.png)

![Topology Diagram](swift-midi-topology.svg)

SwiftMIDIIO adds an I/O layer on top of SwiftMIDICore's MIDI events, providing the essentials to send and receive MIDI events on Apple platforms.

To add additional functionality, import extension modules or import the SwiftMIDI umbrella library which imports all of SwiftMIDI events, I/O, and extensions.

## Topics

### I/O Manager

- ``MIDIManager``
- ``ObservableMIDIManager``
- ``ObservableObjectMIDIManager``
- <doc:MIDIManager-Creating-Ports>
- <doc:MIDIManager-Creating-Connections>
- <doc:MIDIManager-Removing-Ports-and-Connections>
- <doc:MIDIManager-Receiving-Notifications>
- <doc:SwiftUI-and-Combine-Features>

### I/O Devices & Entities

- <doc:Devices>

### I/O Endpoints

- <doc:Endpoints>

### I/O Events

- <doc:Sending-MIDI-Events>
- <doc:Receiving-MIDI-Events>

### Extending Connectivity

- <doc:MIDI-Over-Bluetooth>
- <doc:MIDI-Over-Network>
- <doc:MIDI-Over-USB>

### Additional Topics

- <doc:Send-and-Receive-on-iOS-in-Background>
- <doc:MIDI-Show-Control>
- <doc:Simple-MIDI-Listener-Class-Example>

### I/O Internals

- <doc:Internals>
