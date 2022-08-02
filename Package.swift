// swift-tools-version:5.7

//
// Introductory information is in the `README.md` file in the root directory of the repository this file is in.
// Licensing information is in the `LICENSE.txt` file in the root directory of the repository this file is in.
//

import PackageDescription

let package = Package(
    name: "QueryKit",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
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
