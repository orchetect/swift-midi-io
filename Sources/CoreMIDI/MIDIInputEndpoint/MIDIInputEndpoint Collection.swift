//
//  MIDIInputEndpoint Collection.swift
//  swift-midi • https://github.com/orchetect/swift-midi
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if !os(tvOS) && !os(watchOS)

// MARK: - Static conveniences

extension Set<MIDIEndpointIdentity> {
    /// Returns the current input endpoints in the system.
    public static func currentInputs() -> Self {
        Set(getSystemDestinationEndpoints().asIdentities())
    }
}

extension [MIDIEndpointIdentity] {
    /// Returns the current input endpoints in the system.
    @_disfavoredOverload
    public static func currentInputs() -> Self {
        getSystemDestinationEndpoints().asIdentities()
    }
}

extension Set<MIDIInputEndpoint> {
    /// Returns the current input endpoints in the system.
    public static func currentInputs() -> Self {
        Set(getSystemDestinationEndpoints())
    }
}

extension [MIDIInputEndpoint] {
    /// Returns the current input endpoints in the system.
    @_disfavoredOverload
    public static func currentInputs() -> Self {
        getSystemDestinationEndpoints()
    }
}

#endif
