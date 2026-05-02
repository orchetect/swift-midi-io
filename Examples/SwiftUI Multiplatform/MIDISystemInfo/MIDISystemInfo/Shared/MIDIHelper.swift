//
//  MIDIHelper.swift
//  SwiftMIDI Examples • https://github.com/orchetect/swift-midi-examples
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDIIO
import SwiftUI

/// Object responsible for managing MIDI services, managing connections, and sending/receiving events.
///
/// Conforming the class to `ObservableObject` allows us to install an instance of the class in a SwiftUI App or View
/// and propagate it through the environment.
final class MIDIHelper: ObservableObject, @unchecked Sendable {
    private nonisolated let midiManager = MIDIManager(
        clientName: "MIDISystemInfo",
        model: "TestApp",
        manufacturer: "MyCompany"
    )
    
    @MainActor @Published
    var devices: MIDIDevices?
    
    @MainActor @Published
    var endpoints: MIDIEndpoints?
    
    var devicesMonitor: Task<Void, Never>?
    var endpointsMonitor: Task<Void, Never>?
    
    public init(start: Bool = false) {
        if start { self.start() }
    }
    
    deinit {
        stop()
    }
}

// MARK: - Lifecycle

extension MIDIHelper {
    func start() {
        do {
            print("Starting MIDI services.")
            try midiManager.start()
        } catch {
            print("Error starting MIDI services:", error.localizedDescription)
        }
        
        // set up monitoring task
        devicesMonitor = Task { [weak self, midiManager] in
            print("Devices monitor started.")
            defer { print("Devices monitor finished.") }
            for await devices in midiManager.devicesStream() {
                guard let self else { return }
                await self.updateDevices(devices: devices)
            }
        }
        
        // set up monitoring task
        endpointsMonitor = Task { [weak self, midiManager] in
            print("Endpoints monitor started.")
            defer { print("Endpoints monitor finished.") }
            for await endpoints in midiManager.endpointsStream() {
                guard let self else { return }
                await self.updateEndpoints(endpoints: endpoints)
            }
        }
    }
    
    func stop() {
        devicesMonitor?.cancel()
        devicesMonitor = nil
    }
}

// MARK: - ViewModel

extension MIDIHelper {
    @MainActor
    func updateDevices(devices: MIDIDevices) {
        self.devices = devices
    }
    
    @MainActor
    func updateEndpoints(endpoints: MIDIEndpoints) {
        self.endpoints = endpoints
    }
}
