//
//  MIDIIOObject Properties Dictionary.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if !os(tvOS) && !os(watchOS)

import Foundation
import SwiftMIDIInternals

extension MIDIIOObject {
    // inline docs provided by the MIDIIOObject protocol
    public func propertyStringValues(
        relevantOnly: Bool = false,
        defaultValue: (_ property: MIDIIOObjectProperty, _ error: MIDIIOError?) -> String? = { _, _ in "-" }
    ) -> [(key: String, value: String)] {
        (
            relevantOnly
                ? objectType.relevantProperties
                : MIDIIOObjectProperty.allCases
        )
        .compactMap { property in
            let value: String
            do {
                switch propertyStringValue(for: property) {
                case .notSet:
                    // interpret nil as omission from resulting array, and not "notSet" case
                    guard let newValue = defaultValue(property, nil) else { return nil }
                    value = newValue
                case let .error(error):
                    // interpret nil as omission from resulting array, and not "notSet" case
                    guard let newValue = defaultValue(property, error) else { return nil }
                    value = newValue
                case let .value(v):
                    value = v
                }
            }
            return (key: property.name, value: value)
        }
    }

    // inline docs provided by the MIDIIOObject protocol
    public func propertyStringValue(
        for property: MIDIIOObjectProperty
    ) -> MIDIIOObjectProperty.Value<String> {
        switch property {
        // MARK: Identification

        case .name: // override cache
            try wrapValue(SwiftMIDIIO.getName(of: coreMIDIObjectRef))

        case .model:
            model

        case .manufacturer:
            manufacturer

        case .uniqueID: // override cache
            try wrapValue(SwiftMIDIIO.getUniqueID(of: coreMIDIObjectRef))
                .convertValue { "\($0)" }

        case .deviceID:
            deviceManufacturerID
                .convertValue { "\($0)" }

        // MARK: Capabilities

        case .supportsMMC:
            supportsMMC
                .convertValue { $0 ? "Yes" : "No" }

        case .supportsGeneralMIDI:
            supportsGeneralMIDI
                .convertValue { $0 ? "Yes" : "No" }

        case .supportsShowControl:
            supportsShowControl
                .convertValue { $0 ? "Yes" : "No" }

        // MARK: Configuration

        case .nameConfigurationDictionary:
            if #available(macOS 10.15, macCatalyst 13.0, iOS 13.0, *) {
                nameConfigurationDictionary
                    .convertValue { $0.description }
            } else {
                .error(.notSupported("OS not supported. Requires macOS 10.15, macCatalyst 13.0, or iOS 13.0."))
            }

        case .maxSysExSpeed:
            maxSysExSpeed
                .convertValue { "\($0)" }

        case .driverDeviceEditorApp:
            driverDeviceEditorApp
                .convertValue { $0.absoluteString }

        // MARK: Presentation

        case .image:
            imageFileURL
                .convertValue { $0.absoluteString }

        case .displayName: // override cache
            try wrapValue(SwiftMIDIIO.getDisplayName(of: coreMIDIObjectRef))

        // MARK: Audio

        case .panDisruptsStereo:
            panDisruptsStereo
                .convertValue { $0 ? "Yes" : "No" }

        // MARK: Protocols

        case .protocolID:
            if #available(macOS 11, iOS 14, macCatalyst 14, *) {
                protocolID
                    .convertValue { "\($0)" }
            } else {
                .error(.notSupported("OS not supported. Requires macOS 11.0, macCatalyst 14.0, or iOS 14.0."))
            }

        // MARK: Timing

        case .transmitsMTC:
            transmitsMTC
                .convertValue { $0 ? "Yes" : "No" }

        case .receivesMTC:
            receivesMTC
                .convertValue { $0 ? "Yes" : "No" }

        case .transmitsClock:
            transmitsClock
                .convertValue { $0 ? "Yes" : "No" }

        case .receivesClock:
            receivesClock
                .convertValue { $0 ? "Yes" : "No" }

        case .advanceScheduleTimeMuSec:
            advanceScheduleTimeMuSec
                .convertValue { "\($0)" }

        // MARK: Roles

        case .isMixer:
            isMixer
                .convertValue { $0 ? "Yes" : "No" }

        case .isSampler:
            isSampler
                .convertValue { $0 ? "Yes" : "No" }

        case .isEffectUnit:
            isEffectUnit
                .convertValue { $0 ? "Yes" : "No" }

        case .isDrumMachine:
            isDrumMachine
                .convertValue { $0 ? "Yes" : "No" }

        // MARK: Status

        case .isOffline:
            isOffline
                .convertValue { $0 ? "Yes" : "No" }

        case .isPrivate:
            isPrivate
                .convertValue { $0 ? "Yes" : "No" }

        // MARK: Drivers

        case .driverOwner:
            driverOwner

        case .driverVersion:
            driverVersion
                .convertValue { "\($0)" }

        // MARK: Connections

        case .canRoute:
            canRoute
                .convertValue { $0 ? "Yes" : "No" }

        case .isBroadcast:
            isBroadcast
                .convertValue { $0 ? "Yes" : "No" }

        case .connectionUniqueID:
            connectionUniqueID
                .convertValue { "\($0)" }

        case .isEmbeddedEntity:
            isEmbeddedEntity
                .convertValue { $0 ? "Yes" : "No" }

        case .singleRealtimeEntity:
            singleRealtimeEntity
                .convertValue { "\($0)" }

        // MARK: Channels

        case .receiveChannels:
            receiveChannels
                .convertValue { $0.binaryString(padTo: 8) }

        case .transmitChannels:
            transmitChannels
                .convertValue { $0.binaryString(padTo: 8) }

        case .maxReceiveChannels:
            maxReceiveChannels
                .convertValue { "\($0)" }

        case .maxTransmitChannels:
            maxTransmitChannels
                .convertValue { "\($0)" }

        // MARK: Banks

        case .receivesBankSelectLSB:
            receivesBankSelectLSB
                .convertValue { $0 ? "Yes" : "No" }

        case .receivesBankSelectMSB:
            receivesBankSelectMSB
                .convertValue { $0 ? "Yes" : "No" }

        case .transmitsBankSelectLSB:
            transmitsBankSelectLSB
                .convertValue { $0 ? "Yes" : "No" }

        case .transmitsBankSelectMSB:
            transmitsBankSelectMSB
                .convertValue { $0 ? "Yes" : "No" }

        // MARK: Notes

        case .receivesNotes:
            receivesNotes
                .convertValue { $0 ? "Yes" : "No" }

        case .transmitsNotes:
            transmitsNotes
                .convertValue { $0 ? "Yes" : "No" }

        // MARK: Program Changes

        case .receivesProgramChanges:
            receivesProgramChanges
                .convertValue { $0 ? "Yes" : "No" }

        case .transmitsProgramChanges:
            transmitsProgramChanges
                .convertValue { $0 ? "Yes" : "No" }
        }
    }
}

#endif
