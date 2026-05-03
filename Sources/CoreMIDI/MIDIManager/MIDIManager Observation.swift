//
//  MIDIManager Observation.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if !os(tvOS) && !os(watchOS)

import Foundation

// MARK: - Devices

extension MIDIManager {
    /// An asynchronous sequence that emits MIDI device information in the system in real-time.
    ///
    /// When starting to iterate on the sequence, the initial devices are returned immediately as the first result.
    /// Thereafter, results are only returned when devices change in the system.
    ///
    /// ## Example
    ///
    /// In this example, while the view is loaded, the sequence will receive new results any time the system changes.
    /// The for-loop will automatically exit and `Task` will finish when the view disappears.
    ///
    /// ```swift
    /// struct ContentView: View {
    ///     @State private var devices: [MIDIDevice] = []
    ///
    ///     var body: some View {
    ///         List(devices) { device in
    ///             Text(device.name)
    ///         }
    ///         .task {
    ///             for await devices in midiManager.devicesStream() {
    ///                 self.devices = devices.devices
    ///             }
    ///         }
    ///     }
    /// }
    /// ```
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func devicesStream() -> AsyncStream<MIDIDevices> {
        AsyncStream { continuation in
            let monitor = DevicesMonitor(manager: self) { devices in
                continuation.yield(devices)
            }
            continuation.onTermination = { @Sendable _ in
                monitor.stopMonitoring()
            }
            monitor.startMonitoring()
        }
    }
}

extension MIDIManager {
    /// Internal: Adds a monitor to the manager.
    func addMonitor(_ monitor: DevicesMonitor) {
        devicesMonitors.insert(monitor)
    }

    /// Internal: Removes a monitor from the manager.
    func removeMonitor(_ monitor: DevicesMonitor) {
        devicesMonitors.remove(monitor)
    }
}

extension MIDIManager {
    final class DevicesMonitor: Sendable {
        let id = UUID()
        nonisolated(unsafe) weak var manager: MIDIManager?
        let handler: @Sendable (_ endpoints: MIDIDevices) -> Void

        init(manager: MIDIManager, handler: @escaping @Sendable (_ endpoints: MIDIDevices) -> Void) {
            self.manager = manager
            self.handler = handler
        }

        func startMonitoring() {
            guard let manager else { return }
            manager.addMonitor(self)

            // send initial data
            handler(manager.devices)
        }

        func stopMonitoring() {
            manager?.removeMonitor(self)
        }
    }
}

extension MIDIManager.DevicesMonitor: Equatable {
    static func == (lhs: MIDIManager.DevicesMonitor, rhs: MIDIManager.DevicesMonitor) -> Bool {
        lhs.id == rhs.id
    }
}

extension MIDIManager.DevicesMonitor: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Endpoints

extension MIDIManager {
    /// An asynchronous sequence that emits MIDI endpoint list in the system in real-time.
    ///
    /// When starting to iterate on the sequence, the initial endpoints are returned immediately as the first result.
    /// Thereafter, results are only returned when endpoints change in the system.
    ///
    /// ## Example
    ///
    /// In this example, while the view is loaded, the sequence will receive new results any time the system changes.
    /// The for-loop will automatically exit and `Task` will finish when the view disappears.
    ///
    /// ```swift
    /// struct ContentView: View {
    ///     @State private var inputEndpoints: [MIDIInputEndpoint] = []
    ///     @State private var outputEndpoints: [MIDIOutputEndpoint] = []
    ///
    ///     var body: some View {
    ///         List(inputEndpoints) { endpoint in
    ///             Text(endpoint.displayName)
    ///         }
    ///         List(outputEndpoints) { endpoint in
    ///             Text(endpoint.displayName)
    ///         }
    ///         .task {
    ///             for await endpoints in midiManager.endpointsStream() {
    ///                 inputEndpoints = endpoints.inputs
    ///                 outputEndpoints = endpoints.outputs
    ///             }
    ///         }
    ///     }
    /// }
    /// ```
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func endpointsStream() -> AsyncStream<MIDIEndpoints> {
        AsyncStream { continuation in
            let monitor = EndpointsMonitor(manager: self) { endpoints in
                continuation.yield(endpoints)
            }
            continuation.onTermination = { @Sendable _ in
                monitor.stopMonitoring()
            }
            monitor.startMonitoring()
        }
    }
}

extension MIDIManager {
    /// Internal: Adds a monitor to the manager.
    func addMonitor(_ monitor: EndpointsMonitor) {
        endpointsMonitors.insert(monitor)
    }

    /// Internal: Removes a monitor from the manager.
    func removeMonitor(_ monitor: EndpointsMonitor) {
        endpointsMonitors.remove(monitor)
    }
}

extension MIDIManager {
    final class EndpointsMonitor: Sendable {
        let id = UUID()
        nonisolated(unsafe) weak var manager: MIDIManager?
        let handler: @Sendable (_ endpoints: MIDIEndpoints) -> Void

        init(manager: MIDIManager, handler: @escaping @Sendable (_ endpoints: MIDIEndpoints) -> Void) {
            self.manager = manager
            self.handler = handler
        }

        func startMonitoring() {
            guard let manager else { return }
            manager.addMonitor(self)

            // send initial data
            handler(manager.endpoints)
        }

        func stopMonitoring() {
            manager?.removeMonitor(self)
        }
    }
}

extension MIDIManager.EndpointsMonitor: Equatable {
    static func == (lhs: MIDIManager.EndpointsMonitor, rhs: MIDIManager.EndpointsMonitor) -> Bool {
        lhs.id == rhs.id
    }
}

extension MIDIManager.EndpointsMonitor: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

#endif
