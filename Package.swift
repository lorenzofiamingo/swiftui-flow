// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "swiftui-flow",
    products: [
        .library(
            name: "SwiftUIFlow",
            targets: ["SwiftUIFlow"]),
    ],
    targets: [
        .target(
            name: "SwiftUIFlow",
            dependencies: []
        )
    ]
)
