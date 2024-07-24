// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SDKJSON",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SDKJSON",
            targets: ["SDKJSON"])
    ],
    targets: [
        .binaryTarget(
            name: "SDKJSON", path: "sdk-json.xcframework")
   ]
)
