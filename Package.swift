// swift-tools-version: 5.6

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "PlaygroundAudioKit",
    platforms: [
        .iOS("15.2")
    ],
    products: [
        .iOSApplication(
            name: "PlaygroundAudioKit",
            targets: ["AppModule"],
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .moon),
            accentColor: .presetColor(.blue),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Audiokit/Audiokit", "5.5.7"..<"6.0.0"),
        .package(url: "https://github.com/AudioKit/Keyboard", "1.3.5"..<"2.0.0")
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            dependencies: [
                .product(name: "AudioKit", package: "Audiokit"),
                .product(name: "Keyboard", package: "Keyboard")
            ],
            path: "."
        )
    ]
)
