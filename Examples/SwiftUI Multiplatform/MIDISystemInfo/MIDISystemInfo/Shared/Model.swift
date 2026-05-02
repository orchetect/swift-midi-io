//
//  Model.swift
//  SwiftMIDI I/O • https://github.com/orchetect/swift-midi-io
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDIIO
import SwiftUI

@MainActor
final class Model: ObservableObject, Sendable {
    @Published
    var searchText: String = ""
    
    @Published
    var isOnlySetPropertiesShown: Bool = true
    
    @Published
    var treeItems: [AnyMIDIIOObject] = []
    
    @Published
    var properties: [Property] = []
    
    @Published
    var selectedProperties: Set<Property.ID> = []
    
    nonisolated init() { }
}

// MARK: - Tree

extension Model {
    func updateTreeItems(devices: [MIDIDevice]) {
        treeItems = Self.formatDeviceTreeItems(devices: devices)
    }
    
    nonisolated static func formatDeviceTreeItems(devices: [MIDIDevice]) -> [AnyMIDIIOObject] {
        devices
            .sortedByName()
            .flatMap {
                [$0.asAnyMIDIIOObject()]
                    + $0.entities
                    .flatMap {
                        [$0.asAnyMIDIIOObject()]
                            + $0.inputs.asAnyMIDIIOObjects()
                            + $0.outputs.asAnyMIDIIOObjects()
                    }
            }
    }
}

extension Model {
    var filteredProperties: [Property] {
        guard !searchText
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .isEmpty
        else { return properties }
        
        return properties.filter {
            $0.key.localizedCaseInsensitiveContains(searchText)
                || $0.value.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    func refreshProperties(object: AnyMIDIIOObject) {
        let errorPrefix = "##ERROR##"
        let notSetPrefix = "##NOTSET##"
        
        properties = object.propertyStringValues(relevantOnly: false) { property, error in
            if let error {
                "\(errorPrefix)\(error.localizedDescription)"
            } else {
                // If error is nil, it means property is not set.
                isOnlySetPropertiesShown
                    ? nil
                    : "\(notSetPrefix)Property not set."
            }
        }
        .map {
            var value = $0.value
            
            let status: Property.Status?
            if $0.value.starts(with: errorPrefix) {
                status = .error
                value = String(value.dropFirst(errorPrefix.count))
            } else if $0.value.starts(with: notSetPrefix) {
                status = .notSet
                value = String(value.dropFirst(notSetPrefix.count))
            } else {
                status = nil
            }
            
            return Property(key: $0.key, value: value, status: status)
        }
    }
    
    func selectedItemsProviders() -> [NSItemProvider] {
        let str: String
        
        switch selectedProperties.count {
        case 0:
            return []
            
        case 1: // single
            // just return value
            str = properties
                .first { $0.id == selectedProperties.first! }?
                .value ?? ""
            
        default: // multiple
            // return key/value pairs, one per line
            str = properties
                .filter { selectedProperties.contains($0.key) }
                .map { "\($0.key): \($0.value)" }
                .joined(separator: "\n")
        }
        
        let provider = NSItemProvider(object: str as NSString)
        return [provider]
    }
}
