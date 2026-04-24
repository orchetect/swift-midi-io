# MIDI Show Control

Construct MIDI Show Control messages.

## Background

SwiftMIDI does not currently provide any special abstractions for MIDI Show Control.

The MIDI Show Control spec says:

> MIDI Show Control uses a single Universal Real Time System Exclusive ID number (sub-ID #1 = `0x02`) for all Show commands (transmissions from Controller to Controlled Device).
>
> The format of a Show Control message is as follows:
>
> `F0 7F <device_ID> <msc> <command_format> <command> <data> F7`

## Constructing Events

For details on how to construct System Exclusive messages, see the **MIDIEvent System Exclusive** topic in the SwiftMIDICore documentation.

## See Also

- [MIDI Show Control Specification](https://midi.org/midi-show-control)
