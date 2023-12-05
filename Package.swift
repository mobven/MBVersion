// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MBVersion",
    platforms: [.iOS(.v10)],
    products: [
        .library(
            name: "MBVersion",
            targets: ["MBVersion"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "MBVersion",
            dependencies: []
        ),
        .testTarget(
            name: "MBVersionTests",
            dependencies: ["MBVersion"]
        ),
    ]
)
