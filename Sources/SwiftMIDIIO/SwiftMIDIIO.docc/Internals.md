# Internals

## Topics

### MIDIManager Managed Objects

- ``MIDIInput``
- ``MIDIOutput``
- ``MIDIInputConnection``
- ``MIDIOutputConnection``
- ``MIDIThruConnection``

### Provider Classes and Types

- ``MIDIDevices``
- ``MIDIEndpoints``

### Supporting Types

- ``MIDIInputConnectionMode``
- ``MIDIOutputConnectionMode``
- ``MIDIInputConnectionMode``
- ``MIDIOutputConnectionMode``
- ``MIDIEndpointType``

### MIDI Packets and Parsing

- ``MIDIPacketData``
- ``UniversalMIDIPacketData``
- ``AnyMIDIPacket``
- ``MIDI1Parser``
- ``MIDI2Parser``
- ``AdvancedMIDI2Parser``

### Core MIDI Related

- ``CoreMIDIAPIVersion``
- ``CoreMIDIClientRef``
- ``CoreMIDIObjectRef``
- ``CoreMIDIPortRef``
- ``CoreMIDIDeviceRef``
- ``CoreMIDIEntityRef``
- ``CoreMIDIEndpointRef``
- ``CoreMIDIThruConnectionRef``
- ``CoreMIDITimeStamp``
- ``CoreMIDIOSStatus``

### Errors

- ``MIDIIOError``
- ``MIDIOSStatus``
- ``MIDIInternalError``

### I/O

- ``MIDIIOObject``
- ``MIDIIOObjectType``
- ``MIDIIOObjectProperty``
- ``AnyMIDIIOObject``
- ``MIDIEndpoint``
- ``MIDIDevicesProtocol``
- ``MIDIEndpointsProtocol``
- ``MIDIManaged``
- ``MIDIManagedReceivesMessages``
- ``MIDIManagedSendsMessages``

### MIDIEventList

- ``CoreMIDI/MIDIEventList/init(protocol:packetWords:timeStamp:)``

### MIDIEventPacket

- ``CoreMIDI/MIDIEventPacket/init(words:timeStamp:)``
- ``CoreMIDI/MIDIEventPacket/rawWords``
- ``Swift/UnsafePointer/rawWords``
- ``Swift/UnsafeMutablePointer/rawWords``

### MIDIPacketList (Legacy)

- ``CoreMIDI/MIDIPacketList/init(data:)-([UInt8])``
- ``CoreMIDI/MIDIPacketList/init(data:)-([[UInt8]])``
- ``Swift/UnsafeMutablePointer/init(data:)-([UInt8])``
- ``Swift/UnsafeMutablePointer/init(data:)-([[UInt8]])``
- ``CoreMIDI/MIDIPacketList/packetPointerIterator(_:)``

### MIDIPacket (Legacy)

- ``CoreMIDI/MIDIPacket/rawBytes``
- ``CoreMIDI/MIDIPacket/rawTimeStamp``
- ``Swift/UnsafePointer/rawBytes``
- ``Swift/UnsafePointer/rawTimeStamp``
- ``Swift/UnsafeMutablePointer/rawBytes``
- ``Swift/UnsafeMutablePointer/rawTimeStamp``
