// swift-tools-version:5.4

//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

import PackageDescription

let package = Package(
    name: "QueryKit",
    platforms: [
        .macOS(.v10_10),
        .iOS(.v9),
        .tvOS(.v9),
        .watchOS(.v2)
    ],
    products: [
        .library(
            name: "QueryKit",
            targets: ["QueryKit"]
        )
    ],
    targets: [
        .target(
            name: "QueryKit"
        )
    ]
)
