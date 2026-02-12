// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "VisualDiscoverySDK",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "VisualDiscoverySDK",
            targets: ["VisualDiscoverySDK"]),
    ],
    dependencies: [
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "8.6.2")
    ],
    targets: [
        .target(
            name: "VisualDiscoverySDK",
            dependencies: ["Kingfisher"]),
        .testTarget(
            name: "VisualDiscoverySDKTests",
            dependencies: ["VisualDiscoverySDK"]),
    ]
)
