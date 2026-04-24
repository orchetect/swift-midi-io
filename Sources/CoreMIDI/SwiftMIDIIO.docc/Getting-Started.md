# Getting Started

Basics for getting up and running with MIDI I/O.

![swift-midi-io](swift-midi-io-banner.png)

This is a basic guide intended to help introduce the contents of this package and help get up and running with MIDI I/O.

> Important:
>
> At this time, SwiftMIDI only supports I/O on Apple platforms (macOS, iOS, and visionOS). Support for other platforms
> including Linux, Android, and Windows may be added in future.

## Table of Contents

- [Set up the I/O Manager](#Set-up-the-IO-Manager)
- [Create Ports and Connections](#Create-Ports-and-Connections)
- [Additional Connectivity: Bluetooth, Network, USB](#Additional-Connectivity-Bluetooth-Network-USB)
- [Additional Topics](#Additional-Topics)
- [Examples](#Examples)

## Set up the I/O Manager

Follow the steps in ``MIDIManager`` documentation to create an instance of the manager and start it.

## Create Ports and Connections

From here, you have laid the necessary groundwork to set up ports and connections.

- See <doc:MIDIManager-Creating-Ports>
- See <doc:MIDIManager-Creating-Connections>
- See <doc:MIDIManager-Removing-Ports-and-Connections>

## Additional Connectivity: Bluetooth, Network, USB

- See <doc:MIDI-Over-Bluetooth> for Bluetooth MIDI connectivity on iOS
- See <doc:MIDI-Over-Network> for network MIDI connectivity on macOS or iOS
- See <doc:MIDI-Over-USB> for USB connectivity information on macOS or iOS

## Additional Topics

- <doc:Send-and-Receive-on-iOS-in-Background>
- <doc:MIDI-Show-Control>

## Examples

See the [example projects](https://github.com/orchetect/swift-midi-examples) for demonstration of best practises in using SwiftMIDI.

- term **Barebones MIDI listener**: <doc:Simple-MIDI-Listener-Class-Example>

## Troubleshooting

- term **Error -50**: This usually happens while trying to interact with the ``MIDIManager`` before it's been started, or if your project is sandboxed or targets iOS and the appropriate app entitlements have not been added.
