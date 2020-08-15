// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "__BOTNAME__",
    products: [
        .library(
            name: "__BOTNAME__",
            targets: ["__BOTNAME__"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/dmoroz0v/ChatBotSDK.git", from: "0.0.0")
    ],
    targets: [
        .target(
            name: "__BOTNAME__",
            dependencies: [
                "ChatBotSDK"
            ]
        ),
    ]
)
