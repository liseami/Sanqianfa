// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Sanqianfa",
    dependencies: [
        .package(url: "https://github.com/Recouse/EventSource.git", from: "0.1.3")
    ],
    targets: [
        .target(
            name: "Sanqianfa",
            dependencies: []
        ),
        .testTarget(
            name: "SanqianfaTests",
            dependencies: ["Sanqianfa"]
        )
    ]
)
