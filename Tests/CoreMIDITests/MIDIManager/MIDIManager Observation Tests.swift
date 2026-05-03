//
//  MIDIManager Observation Tests.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if !os(tvOS) && !os(watchOS)

import Foundation
@testable import SwiftMIDIIO
import Testing
import TestingExtensions

@Suite
struct MIDIManager_Observation_Tests {
    static let clientName = UUID().uuidString

    let manager = MIDIManager(
        clientName: clientName,
        model: "SwiftMIDI123",
        manufacturer: "SwiftMIDI"
    )

    init() throws {
        try manager.start()
    }

    /// This test checks the lifecycle behavior of the async stream.
    /// Actual data returned from the stream is not checked in this test.
    @Test
    func devicesStream_Lifecycle() async throws {
        actor TestState {
            var resultCount = 0
            func incResultCount() {
                resultCount += 1
            }

            var isFinished = false
            func setIsFinished(_ value: Bool) {
                isFinished = value
            }

            init() { }
        }

        let testState = TestState()

        var task: Task? = Task {
            for await devices in manager.devicesStream() {
                // we don't care about the actual data here for this test
                _ = devices

                await testState.incResultCount()
            }
            await testState.setIsFinished(true)
        }

        // wait for sequence to start
        try await wait(require: { await testState.resultCount == 1 }, timeout: 2.0)

        // wait a short amount of time to ensure the sequence has not finished
        try await Task.sleep(seconds: 0.5)
        #expect(await !testState.isFinished)

        // cancel the task
        task?.cancel()
        task = nil

        // check if the sequence finishes as a result
        await wait(expect: { await testState.isFinished }, timeout: 2.0)

        // ensure the sequence cleans itself up by removing itself from the manager
        await wait(expect: { manager.devicesMonitors.isEmpty }, timeout: 2.0)
    }

    /// This tests that the expected data is returned by the stream.
    /// There is no viable way to test devices changing in a live system, as we cannot add or remove MIDI devices
    /// like we can with virtual endpoints.
    @Test
    func devicesStream_Data() async throws {
        actor TestState {
            var devices: MIDIDevices?
            func updateDevices(_ devices: MIDIDevices) {
                self.devices = devices
            }

            init() { }
        }

        let testState = TestState()
        let originalDevices = manager.devices

        var task: Task? = Task {
            for await devices in manager.devicesStream() {
                await testState.updateDevices(devices)
            }
        }

        // wait for the sequence to start and receive the first result
        try await wait(require: { await testState.devices == originalDevices }, timeout: 2.0)

        // clean up
        task?.cancel()
        task = nil
    }

    /// This test checks the lifecycle behavior of the async stream.
    /// Actual data returned from the stream is not checked in this test.
    @Test
    func endpointsStream_Lifecycle() async throws {
        actor TestState {
            var resultCount = 0
            func incResultCount() {
                resultCount += 1
            }

            var isFinished = false
            func setIsFinished(_ value: Bool) {
                isFinished = value
            }

            init() { }
        }

        let testState = TestState()

        var task: Task? = Task {
            for await endpoints in manager.endpointsStream() {
                // we don't care about the actual data here for this test
                _ = endpoints

                await testState.incResultCount()
            }
            await testState.setIsFinished(true)
        }

        // wait for sequence to start
        try await wait(require: { await testState.resultCount == 1 }, timeout: 2.0)

        // wait a short amount of time to ensure the sequence has not finished
        try await Task.sleep(seconds: 0.5)
        #expect(await !testState.isFinished)

        // cancel the task
        task?.cancel()
        task = nil

        // check if the sequence finishes as a result
        await wait(expect: { await testState.isFinished }, timeout: 2.0)

        // ensure the sequence cleans itself up by removing itself from the manager
        await wait(expect: { manager.endpointsMonitors.isEmpty }, timeout: 2.0)
    }

    // iOS Simulator testing does not give enough permissions to allow creating virtual MIDI
    // ports, so skip these tests on iOS targets
    #if !targetEnvironment(simulator)
    /// This tests that the expected data is returned by the stream.
    @Test
    func endpointsStream_Data() async throws {
        actor TestState {
            var endpoints: MIDIEndpoints?
            func updateEndpoints(_ endpoints: MIDIEndpoints) {
                self.endpoints = endpoints
            }

            init() { }
        }

        let testState = TestState()
        let originalEndpoints = manager.endpoints

        var task: Task? = Task {
            for await endpoints in manager.endpointsStream() {
                await testState.updateEndpoints(endpoints)
            }
        }

        // wait for the sequence to start and receive the first result
        try await wait(require: { await testState.endpoints == originalEndpoints }, timeout: 2.0)

        let name = UUID().uuidString
        try manager.addOutput(name: name, tag: name, uniqueID: .adHoc)

        // wait for the manager to update
        await wait(expect: { manager.managedOutputs.contains(where: { $0.value.name == name }) }, timeout: 2.0)
        await wait(expect: { manager.endpoints.outputsOwned.count == 1 }, timeout: 2.0)
        let output = try #require(manager.endpoints.outputsOwned.first)
        await wait(expect: {
            Set(manager.endpoints.inputs) == Set(originalEndpoints.inputs)
            && Set(manager.endpoints.outputs) == Set(originalEndpoints.outputs + [output])
        }, timeout: 2.0)

        // wait for the sequence to emit the new data
        try await wait(require: {
            guard let e = await testState.endpoints else { return false }
            return Set(e.inputs) == Set(originalEndpoints.inputs)
            && Set(e.outputs) == Set(originalEndpoints.outputs + [output])
        }, timeout: 2.0)

        // clean up
        task?.cancel()
        task = nil
    }
    #endif
}

#endif
