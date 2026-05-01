//
//  Core MIDI Entities.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if !os(tvOS) && !os(watchOS)

import CoreMIDI
import Foundation

/// Internal:
/// Return the owning device of the entity.
func getSystemDevice(
    forEntity entityRef: CoreMIDI.MIDIEntityRef
) throws(MIDIIOError) -> MIDIDevice? {
    let refPtr: UnsafeMutablePointer<MIDIDeviceRef>? = nil

    // safeguard: ensure ref is an entity, otherwise we get a crash when calling MIDIEndpointGetDevice
    let uid = try getUniqueID(of: entityRef)
    let objType = try getSystemObjectType(ofUniqueID: uid)
    guard [.entity, .externalEntity].contains(objType) else {
        throw .internalInconsistency("Wrong object type.")
    }
    
    try MIDIEntityGetDevice(entityRef, refPtr)
        .throwIfOSStatusErr()

    guard let refPtr else { return nil }
    guard refPtr.pointee != MIDIDeviceRef() else { return nil }

    return MIDIDevice(from: refPtr.pointee)
}

/// Internal:
/// List of source endpoints for the entity (computed property)
func getSystemSourceEndpoints(
    forEntity entityRef: CoreMIDI.MIDIEntityRef
) -> [MIDIOutputEndpoint] {
    let srcCount = MIDIEntityGetNumberOfSources(entityRef)

    var endpoints: [MIDIOutputEndpoint] = []
    endpoints.reserveCapacity(srcCount)

    for i in 0 ..< srcCount {
        let endpointRef = MIDIEntityGetSource(entityRef, i)
        let endpoint = MIDIOutputEndpoint(from: endpointRef)
        guard endpoint.uniqueID != .invalidMIDIIdentifier else { continue }
        endpoints.append(endpoint)
    }

    return endpoints
}

/// Internal:
/// List of destination endpoints for the entity (computed property)
func getSystemDestinationEndpoints(
    forEntity entityRef: CoreMIDI.MIDIEntityRef
) -> [MIDIInputEndpoint] {
    let srcCount = MIDIEntityGetNumberOfDestinations(entityRef)

    var endpoints: [MIDIInputEndpoint] = []
    endpoints.reserveCapacity(srcCount)

    for i in 0 ..< srcCount {
        let endpointRef = MIDIEntityGetDestination(entityRef, i)
        let endpoint = MIDIInputEndpoint(from: endpointRef)
        guard endpoint.uniqueID != .invalidMIDIIdentifier else { continue }
        endpoints.append(endpoint)
    }

    return endpoints
}

#endif
