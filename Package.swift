// swift-tools-version: 6.0

import Foundation
import PackageDescription

let package = Package(
    name: "swift-midi-io",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v12),
        .tvOS(.v12),
        .watchOS(.v4)
    ],
    products: [
        .library(
            name: "SwiftMIDIIO",
            targets: ["SwiftMIDIIO"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/orchetect/swift-midi-core", from: "1.0.0"),
        .package(url: "https://github.com/orchetect/swift-testing-extensions", from: "0.3.1")
    ]
)

// MARK: - Platform-Dependent I/O Backend

#if canImport(Darwin)
    package.targets += [
        .target(
            name: "SwiftMIDIIO",
            dependencies: [
                .product(name: "SwiftMIDICore", package: "swift-midi-core"),
                .product(name: "SwiftMIDIInternals", package: "swift-midi-core")
            ],
            path: "Sources/CoreMIDI",
            swiftSettings: [.define("DEBUG", .when(configuration: .debug))]
        ),
        .testTarget(
            name: "SwiftMIDIIOTests",
            dependencies: [
                "SwiftMIDIIO",
                .product(name: "TestingExtensions", package: "swift-testing-extensions")
            ],
            path: "Tests/CoreMIDITests"
        )
    ]
#else
    package.targets += [
        .target(
            name: "SwiftMIDIIO",
            path: "Sources/Unsupported"
        )
    ]
#endif

// MARK: - Utilities

func hasEnvironmentVariable(_ name: String) -> Bool {
    ProcessInfo.processInfo.environment[name] != nil
}

// MARK: - CI Pipeline

if hasEnvironmentVariable("GITHUB_ACTIONS") {
    for target in package.targets {
        if target.swiftSettings == nil { target.swiftSettings = [] }
        target.swiftSettings? += [.define("GITHUB_ACTIONS", .when(configuration: .debug))]
    }
}
