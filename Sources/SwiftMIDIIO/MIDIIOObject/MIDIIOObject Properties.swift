//
//  MIDIIOObject Properties.swift
//  swift-midi • https://github.com/orchetect/swift-midi
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if !os(tvOS) && !os(watchOS)

import Foundation
import CoreMIDI

#if canImport(SwiftUI)
import SwiftUI
#endif

#if canImport(AppKit)
import AppKit
#endif

#if canImport(UIKit)
import UIKit
#endif

// MARK: - Properties (Computed)

// NOTE: Inline documentation is already supplied by the MIDIIOObject protocol

extension MIDIIOObject {
    // MARK: Identification
    
    // NOTE: `name` is a cached property and is managed by the object instance.
    // public var name: String
    
    public var model: MIDIIOObjectProperty.Value<String> {
        wrapValue(try SwiftMIDIIO.getModel(of: coreMIDIObjectRef))
    }
    
    public var manufacturer: MIDIIOObjectProperty.Value<String> {
        wrapValue(try SwiftMIDIIO.getManufacturer(of: coreMIDIObjectRef))
    }
    
    // NOTE: `uniqueID` is a cached property and is managed by the object instance.
    // public var uniqueID: MIDIIdentifier
    
    public var deviceManufacturerID: MIDIIOObjectProperty.Value<Int32> {
        wrapValue(try SwiftMIDIIO.getDeviceManufacturerID(of: coreMIDIObjectRef))
    }
    
    // MARK: Capabilities
    
    public var supportsMMC: MIDIIOObjectProperty.Value<Bool> {
        wrapValue(try SwiftMIDIIO.getSupportsMMC(of: coreMIDIObjectRef))
    }
    
    public var supportsGeneralMIDI: MIDIIOObjectProperty.Value<Bool> {
        wrapValue(try SwiftMIDIIO.getSupportsGeneralMIDI(of: coreMIDIObjectRef))
    }
    
    public var supportsShowControl: MIDIIOObjectProperty.Value<Bool> {
        wrapValue(try SwiftMIDIIO.getSupportsShowControl(of: coreMIDIObjectRef))
    }
    
    // MARK: Configuration
    
    @available(macOS 10.15, macCatalyst 13.0, iOS 13.0, *)
    public var nameConfigurationDictionary: MIDIIOObjectProperty.Value<NSDictionary> {
        wrapValue(try SwiftMIDIIO.getNameConfigurationDictionary(of: coreMIDIObjectRef))
    }
    
    public var maxSysExSpeed: MIDIIOObjectProperty.Value<Int32> {
        wrapValue(try SwiftMIDIIO.getMaxSysExSpeed(of: coreMIDIObjectRef))
    }
    
    public var driverDeviceEditorApp: MIDIIOObjectProperty.Value<URL> {
        wrapValue(try SwiftMIDIIO.getDriverDeviceEditorApp(of: coreMIDIObjectRef))
    }
    
    // MARK: Presentation
    
    #if canImport(SwiftUI)
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public var image: MIDIIOObjectProperty.Value<Image> {
        #if os(macOS)
        return imageAsNSImage.convertValue { Image(nsImage: $0) }
        #elseif os(iOS)
        return imageAsUIImage.convertValue { Image(uiImage: $0) }
        #else
        return .error(.notSupported("Not yet supported on this platform."))
        #endif
    }
    #endif
    
    public var imageFileURL: MIDIIOObjectProperty.Value<URL> {
        wrapValue(try SwiftMIDIIO.getImage(of: coreMIDIObjectRef))
    }
    
    #if canImport(AppKit) && os(macOS)
    public var imageAsNSImage: MIDIIOObjectProperty.Value<NSImage> {
        imageFileURL.convertValue { NSImage(contentsOf: $0) }
    }
    #endif
    
    #if canImport(UIKit)
    public var imageAsUIImage: MIDIIOObjectProperty.Value<UIImage> {
        imageFileURL.convertValue { url throws(MIDIIOError) in
            do {
                let data = try Data(contentsOf: url)
                return UIImage(data: data)
            } catch {
                throw .malformed("Failed to read MIDI object image data. (\(error.localizedDescription))")
            }
        }
    }
    #endif
    
    // NOTE: `displayName` is a cached property and is managed by the object instance.
    // public var name: String
    
    // MARK: Audio
    
    public var panDisruptsStereo: MIDIIOObjectProperty.Value<Bool> {
        wrapValue(try SwiftMIDIIO.getPanDisruptsStereo(of: coreMIDIObjectRef))
    }
    
    // MARK: Protocol
    
    @available(macOS 11.0, macCatalyst 14.0, iOS 14.0, *)
    public var protocolID: MIDIIOObjectProperty.Value<MIDIProtocolVersion> {
        wrapValue(try SwiftMIDIIO.getProtocolID(of: coreMIDIObjectRef))
            .convertValue { MIDIProtocolVersion($0) }
    }
    
    // MARK: Timing
    
    public var transmitsMTC: MIDIIOObjectProperty.Value<Bool> {
        wrapValue(try SwiftMIDIIO.getTransmitsMTC(of: coreMIDIObjectRef))
    }
    
    public var receivesMTC: MIDIIOObjectProperty.Value<Bool> {
        wrapValue(try SwiftMIDIIO.getReceivesMTC(of: coreMIDIObjectRef))
    }
    
    public var transmitsClock: MIDIIOObjectProperty.Value<Bool> {
        wrapValue(try SwiftMIDIIO.getTransmitsClock(of: coreMIDIObjectRef))
    }
    
    public var receivesClock: MIDIIOObjectProperty.Value<Bool> {
        wrapValue(try SwiftMIDIIO.getReceivesClock(of: coreMIDIObjectRef))
    }
    
    public var advanceScheduleTimeMuSec: MIDIIOObjectProperty.Value<String> {
        wrapValue(try SwiftMIDIIO.getAdvanceScheduleTimeMuSec(of: coreMIDIObjectRef))
    }
    
    // MARK: Roles
    
    public var isMixer: MIDIIOObjectProperty.Value<Bool> {
        wrapValue(try SwiftMIDIIO.getIsMixer(of: coreMIDIObjectRef))
    }
    
    public var isSampler: MIDIIOObjectProperty.Value<Bool> {
        wrapValue(try SwiftMIDIIO.getIsSampler(of: coreMIDIObjectRef))
    }
    
    public var isEffectUnit: MIDIIOObjectProperty.Value<Bool> {
        wrapValue(try SwiftMIDIIO.getIsEffectUnit(of: coreMIDIObjectRef))
    }
    
    public var isDrumMachine: MIDIIOObjectProperty.Value<Bool> {
        wrapValue(try SwiftMIDIIO.getIsDrumMachine(of: coreMIDIObjectRef))
    }
    
    // MARK: Status
    
    public var isOffline: MIDIIOObjectProperty.Value<Bool> {
        wrapValue(try SwiftMIDIIO.getIsOffline(of: coreMIDIObjectRef))
    }
    
    public var isPrivate: MIDIIOObjectProperty.Value<Bool> {
        wrapValue(try SwiftMIDIIO.getIsPrivate(of: coreMIDIObjectRef))
    }
    
    // MARK: Drivers
    
    public var driverOwner: MIDIIOObjectProperty.Value<String> {
        wrapValue(try SwiftMIDIIO.getDriverOwner(of: coreMIDIObjectRef))
    }
    
    public var driverVersion: MIDIIOObjectProperty.Value<Int32> {
        wrapValue(try SwiftMIDIIO.getDriverVersion(of: coreMIDIObjectRef))
    }
    
    // MARK: Connections
    
    public var canRoute: MIDIIOObjectProperty.Value<Bool> {
        wrapValue(try SwiftMIDIIO.getCanRoute(of: coreMIDIObjectRef))
    }
    
    public var isBroadcast: MIDIIOObjectProperty.Value<Bool> {
        wrapValue(try SwiftMIDIIO.getIsBroadcast(of: coreMIDIObjectRef))
    }
    
    public var connectionUniqueID: MIDIIOObjectProperty.Value<MIDIIdentifier> {
        wrapValue(try SwiftMIDIIO.getConnectionUniqueID(of: coreMIDIObjectRef))
    }
    
    public var isEmbeddedEntity: MIDIIOObjectProperty.Value<Bool> {
        wrapValue(try SwiftMIDIIO.getIsEmbeddedEntity(of: coreMIDIObjectRef))
    }
    
    public var singleRealtimeEntity: MIDIIOObjectProperty.Value<Int32> {
        wrapValue(try SwiftMIDIIO.getSingleRealtimeEntity(of: coreMIDIObjectRef))
    }
    
    // MARK: Channels
    
    public var receiveChannels: MIDIIOObjectProperty.Value<Int32> {
        wrapValue(try SwiftMIDIIO.getReceiveChannels(of: coreMIDIObjectRef))
    }
    
    public var transmitChannels: MIDIIOObjectProperty.Value<Int32> {
        wrapValue(try SwiftMIDIIO.getTransmitChannels(of: coreMIDIObjectRef))
    }
    
    public var maxReceiveChannels: MIDIIOObjectProperty.Value<Int32> {
        wrapValue(try SwiftMIDIIO.getMaxReceiveChannels(of: coreMIDIObjectRef))
    }
    
    public var maxTransmitChannels: MIDIIOObjectProperty.Value<Int32> {
        wrapValue(try SwiftMIDIIO.getMaxTransmitChannels(of: coreMIDIObjectRef))
    }
    
    // MARK: Banks
    
    public var receivesBankSelectLSB: MIDIIOObjectProperty.Value<Bool> {
        wrapValue(try SwiftMIDIIO.getReceivesBankSelectLSB(of: coreMIDIObjectRef))
    }
    
    public var receivesBankSelectMSB: MIDIIOObjectProperty.Value<Bool> {
        wrapValue(try SwiftMIDIIO.getReceivesBankSelectMSB(of: coreMIDIObjectRef))
    }
    
    public var transmitsBankSelectLSB: MIDIIOObjectProperty.Value<Bool> {
        wrapValue(try SwiftMIDIIO.getTransmitsBankSelectLSB(of: coreMIDIObjectRef))
    }
    
    public var transmitsBankSelectMSB: MIDIIOObjectProperty.Value<Bool> {
        wrapValue(try SwiftMIDIIO.getTransmitsBankSelectMSB(of: coreMIDIObjectRef))
    }
    
    // MARK: Notes
    
    public var receivesNotes: MIDIIOObjectProperty.Value<Bool> {
        wrapValue(try SwiftMIDIIO.getReceivesNotes(of: coreMIDIObjectRef))
    }
    
    public var transmitsNotes: MIDIIOObjectProperty.Value<Bool> {
        wrapValue(try SwiftMIDIIO.getTransmitsNotes(of: coreMIDIObjectRef))
    }
    
    // MARK: Program Changes
    
    public var receivesProgramChanges: MIDIIOObjectProperty.Value<Bool> {
        wrapValue(try SwiftMIDIIO.getReceivesProgramChanges(of: coreMIDIObjectRef))
    }
    
    public var transmitsProgramChanges: MIDIIOObjectProperty.Value<Bool> {
        wrapValue(try SwiftMIDIIO.getTransmitsProgramChanges(of: coreMIDIObjectRef))
    }
}

// MARK: - Helpers

func wrapValue<T>(_ block: @autoclosure () throws(MIDIIOError) -> T?) -> MIDIIOObjectProperty.Value<T> {
    do throws(MIDIIOError) {
        guard let value = try block() else {
            // interpret nil as property not being set
            return .notSet
        }
        return .value(value)
    } catch {
        switch error {
        case .osStatus(.unknownProperty): return .notSet
        default: return .error(error)
        }
    }
}

#endif
