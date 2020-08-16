// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BotDependencies",
    products: [
        .library(
            name: "BotDependencies",
            targets: ["BotDependencies"]
        ),
    ],
    dependencies: [
        .package(path: "../../__BOTNAME__"),
        .package(url: "https://github.com/dmoroz0v/TgBotSDK.git", .exact("__TAG__")),
    ],
    targets: [
        .target(
            name: "BotDependencies",
            dependencies: [
                "__BOTNAME__",
                "TgBotSDK",
            ]
        ),
    ]
)
