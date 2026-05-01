//
//  MIDIManager State.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if !os(tvOS) && !os(watchOS)

import CoreMIDI
import Foundation
import SwiftMIDICore

extension MIDIManager {
    /// Starts the manager and registers itself with the Core MIDI subsystem.
    /// Call this method once after initializing a new instance.
    /// Subsequent calls will not have any effect.
    ///
    /// - Throws: `MIDIIOError.osStatus`
    public func start() throws(MIDIIOError) {
        try managementQueue.syncTypedThrowable { () throws(MIDIIOError) in
            // if start() was already called, return
            guard coreMIDIClientRef == MIDIClientRef() else { return }
            
            func block() -> Result<MIDIClientRef, MIDIIOError> {
                var newCoreMIDIClientRef = MIDIClientRef()
                
                do throws(MIDIIOError) {
                    try MIDIClientCreateWithBlock(clientName as CFString, &newCoreMIDIClientRef) { [weak self] notificationPtr in
                        guard let self else { return }
                        let internalNotif = MIDIIOInternalNotification(notificationPtr)
                        internalNotificationHandler(internalNotif)
                    }
                    .throwIfOSStatusErr()
                    
                    return .success(newCoreMIDIClientRef)
                } catch {
                    return .failure(error)
                }
            }
            
            // `MIDIClientCreateWithBlock` must be called on the main thread,
            // otherwise the notification block will never happen.
            let newCoreMIDIClientRef: MIDIClientRef
            if Thread.current.isMainThread {
                newCoreMIDIClientRef = try block().get()
            } else {
                let result = DispatchQueue.main.sync { block() }
                newCoreMIDIClientRef = try result.get()
            }
            assert(newCoreMIDIClientRef != MIDIClientRef())
            coreMIDIClientRef = newCoreMIDIClientRef
        }
            
        // initial cache of endpoints
        updateDevicesAndEndpoints()
    }

    private func internalNotificationHandler(_ internalNotif: MIDIIOInternalNotification) {
        switch internalNotif {
        case .setupChanged, .added, .removed, .propertyChanged:
            updateDevicesAndEndpoints()
        default:
            break
        }

        // if needed, fall back on notification cache in case we get more than
        // one `.removed` notification in a row. this way we have metadata on hand.
        let notification = MIDIIONotification(internalNotif, cache: midiObjectCache)

        // propagate notification to managed objects
        for outputConnection in managedOutputConnections.values {
            outputConnection.notification(internalNotif)
        }
        for inputConnection in managedInputConnections.values {
            inputConnection.notification(internalNotif)
        }
        for thruConnection in managedThruConnections.values {
            thruConnection.notification(internalNotif)
        }

        // send notification to handler after internal cache is updated
        if let notification {
            sendNotificationAsync(notification)
        }
    }

    private func sendNotificationAsync(_ notif: MIDIIONotification) {
        guard let notificationHandler else { return }
        DispatchQueue.main.async {
            notificationHandler(notif)
        }
    }
}

#endif
