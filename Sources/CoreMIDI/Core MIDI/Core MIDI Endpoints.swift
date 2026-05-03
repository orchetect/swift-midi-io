//
//  Core MIDI Endpoints.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if !os(tvOS) && !os(watchOS)

import CoreMIDI

// MARK: - Sources

/// Internal:
/// List of MIDI endpoints in the system (computed property)
func getSystemSourceEndpoints() -> [MIDIOutputEndpoint] {
    let srcCount = MIDIGetNumberOfSources()

    var endpoints: [MIDIOutputEndpoint] = []
    endpoints.reserveCapacity(srcCount)

    for i in 0 ..< srcCount {
        let endpointRef = MIDIGetSource(i)
        guard endpointRef != MIDIEndpointRef() else { continue }
        let endpoint = MIDIOutputEndpoint(from: endpointRef)
        guard endpoint.uniqueID != .invalidMIDIIdentifier else { continue }
        endpoints.append(endpoint)
    }

    return endpoints
}

// MARK: - Destinations

/// Internal:
/// Dictionary of destination names & endpoint unique IDs (computed property)
func getSystemDestinationEndpointRefs() -> [CoreMIDI.MIDIEndpointRef] {
    let destCount = MIDIGetNumberOfDestinations()

    var refs: [CoreMIDI.MIDIEndpointRef] = []
    refs.reserveCapacity(destCount)

    for i in 0 ..< destCount {
        let endpointRef = MIDIGetDestination(i)
        guard endpointRef != MIDIEndpointRef() else { continue }
        refs.append(endpointRef)
    }

    return refs
}

/// Internal:
/// Dictionary of destination names & endpoint unique IDs (computed property)
func getSystemDestinationEndpoints() -> [MIDIInputEndpoint] {
    let destCount = MIDIGetNumberOfDestinations()

    var endpoints: [MIDIInputEndpoint] = []
    endpoints.reserveCapacity(destCount)

    for i in 0 ..< destCount {
        let endpointRef = MIDIGetDestination(i)
        guard endpointRef != MIDIEndpointRef() else { continue }
        let endpoint = MIDIInputEndpoint(from: endpointRef)
        guard endpoint.uniqueID != .invalidMIDIIdentifier else { continue }
        endpoints.append(endpoint)
    }

    return endpoints
}

/// Internal:
/// Returns all source `MIDIEndpointRef`s in the system that have a name matching `name`.
///
/// - Parameters:
///   - name: MIDI port name to search for.
func getSystemSourceEndpointRefs(
    matching name: String
) -> [CoreMIDI.MIDIEndpointRef] {
    var refs: [CoreMIDI.MIDIEndpointRef] = []

    for i in 0 ..< MIDIGetNumberOfSources() {
        let endpointRef = MIDIGetSource(i)
        guard endpointRef != 0 else { continue }
        if (try? getName(of: endpointRef)) == name { refs.append(endpointRef) }
    }

    return refs
}

/// Internal:
/// Returns the first source `MIDIEndpointRef` in the system with a unique ID matching `uniqueID`.
/// If not found, returns `nil`.
///
/// - Parameters:
///   - uniqueID: MIDI port unique ID to search for.
func getSystemSourceEndpointRef(
    matching uniqueID: CoreMIDI.MIDIUniqueID
) -> CoreMIDI.MIDIEndpointRef? {
    guard uniqueID != .invalidMIDIIdentifier else { return nil }

    for i in 0 ..< MIDIGetNumberOfSources() {
        let endpointRef = MIDIGetSource(i)
        guard endpointRef != 0 else { continue }
        if (try? getUniqueID(of: endpointRef)) == uniqueID { return endpointRef }
    }

    return nil
}

/// Internal:
/// Returns all destination `MIDIEndpointRef`s in the system that have a name matching `name`.
///
/// - Parameters:
///   - name: MIDI port name to search for.
func getSystemDestinationEndpointRefs(
    matching name: String
) -> [CoreMIDI.MIDIEndpointRef] {
    var refs: [MIDIEndpointRef] = []

    for i in 0 ..< MIDIGetNumberOfDestinations() {
        let endpointRef = MIDIGetDestination(i)
        guard endpointRef != 0 else { continue }
        if (try? getName(of: endpointRef)) == name { refs.append(endpointRef) }
    }

    return refs
}

/// Internal:
/// Returns the first destination `MIDIEndpointRef` in the system with a unique ID matching
/// `uniqueID`. If not found, returns `nil`.
///
/// - Parameters:
///   - uniqueID: MIDI port unique ID to search for.
func getSystemDestinationEndpointRef(
    matching uniqueID: CoreMIDI.MIDIUniqueID
) -> CoreMIDI.MIDIEndpointRef? {
    guard uniqueID != .invalidMIDIIdentifier else { return nil }

    for i in 0 ..< MIDIGetNumberOfDestinations() {
        let endpointRef = MIDIGetDestination(i)
        guard endpointRef != 0 else { continue }
        if (try? getUniqueID(of: endpointRef)) == uniqueID { return endpointRef }
    }

    return nil
}

/// Internal:
/// Returns a ``MIDIEntity`` instance of the endpoint's owning entity.
func getSystemEntity(
    forEndpoint endpointRef: CoreMIDI.MIDIEndpointRef
) throws(MIDIIOError) -> MIDIEntity? {
    // note: don't use a pointer here, use a plain var and pass it inout to MIDIEndpointGetEntity otherwise we get crashes
    var entityRef = MIDIEntityRef()

    try MIDIEndpointGetEntity(endpointRef, &entityRef)
        .throwIfOSStatusErr()

    guard entityRef != MIDIEntityRef() else { return nil }

    return MIDIEntity(from: entityRef)
}

/// Internal:
/// Makes a virtual endpoint in the system invisible to the user.
func hide(endpoint endpointRef: CoreMIDI.MIDIEndpointRef) throws(MIDIIOError) {
    try MIDIObjectSetIntegerProperty(endpointRef, kMIDIPropertyPrivate, 1)
        .throwIfOSStatusErr()
}

/// Internal:
/// Makes a virtual endpoint in the system visible to the user.
func show(endpoint endpointRef: CoreMIDI.MIDIEndpointRef) throws(MIDIIOError) {
    try MIDIObjectSetIntegerProperty(endpointRef, kMIDIPropertyPrivate, 0)
        .throwIfOSStatusErr()
}

#endif
