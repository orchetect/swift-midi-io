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
        .package(url: "https://github.com/orchetect/swift-midi-core", branch: "main"), // TODO: from: "0.1.0")
        .package(url: "https://github.com/orchetect/swift-testing-extensions", from: "0.3.0")
    ],
    targets: [
        .target(
            name: "SwiftMIDIIO",
            dependencies: [
                .product(name: "SwiftMIDICore", package: "swift-midi-core"),
                .product(name: "SwiftMIDIInternals", package: "swift-midi-core")
            ],
            swiftSettings: [.define("DEBUG", .when(configuration: .debug))]
        ),
        .testTarget(
            name: "SwiftMIDIIOTests",
            dependencies: [
                "SwiftMIDIIO",
                .product(name: "TestingExtensions", package: "swift-testing-extensions")
            ]
        )
    ]
)

#if canImport(Foundation) || canImport(CoreFoundation)
    #if canImport(Foundation)
        import class Foundation.ProcessInfo

        func getEnvironmentVar(_ name: String) -> String? {
            ProcessInfo.processInfo.environment[name]
        }

    #elseif canImport(CoreFoundation)
        import CoreFoundation

        func getEnvironmentVar(_ name: String) -> String? {
            guard let rawValue = getenv(name) else { return nil }
            return String(utf8String: rawValue)
        }
    #endif

    func isEnvironmentVarTrue(_ name: String) -> Bool {
        guard let value = getEnvironmentVar(name)?
            .trimmingCharacters(in: .whitespacesAndNewlines)
        else { return false }
        return ["true", "yes", "1"].contains(value.lowercased())
    }

    // MARK: - DocC Dependency

    // Conditionally opt-in to Swift DocC Plugin when an environment flag is present.
    if isEnvironmentVarTrue("ENABLE_DOCC_PLUGIN") {
        package.dependencies += [
            .package(url: "https://github.com/swiftlang/swift-docc-plugin.git", from: "1.4.5"),
        ]
    }

    // MARK: - CI Pipeline

    if isEnvironmentVarTrue("GITHUB_ACTIONS") {
        for target in package.targets.filter(\.isTest) {
            if target.swiftSettings == nil { target.swiftSettings = [] }
            target.swiftSettings? += [.define("GITHUB_ACTIONS", .when(configuration: .debug))]
        }
    }
#endif
