// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let version = "0.3.13.3"
let url = "https://gitlab.futo.org/api/v4/projects/125/packages/generic/matrix-sdk-crypto-ffi-\(version)/\(version)/MatrixSDKCryptoFFI.zip"
let checksum = "c97f4b721c86e05965386a9a232617c56be78dc99073ac0e84654417d1867bed"

let package = Package(
    name: "MatrixSDKCrypto",
    platforms: [
        .iOS(.v15),
        .tvOS(.v15),
        .macCatalyst(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "MatrixSDKCrypto",
            targets: ["MatrixSDKCrypto"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
            name: "MatrixSDKCryptoFFI",
            url: url,
            checksum: checksum
        ),
        /*
            Apparently we can't build our Swift package library directly from the FFI target.
            We need a sort of intermediate build target as a go-between.
            This technique comes from the Matrix Rust components package: 
            https://github.com/matrix-org/matrix-rust-components-swift/blob/f4ff25f54c7e854fa1498f6dfd7bedca8c0ed260/Package.swift#L32
        */
        .target(
            name: "MatrixSDKCrypto",
            dependencies: [
                .target(name: "MatrixSDKCryptoFFI")
            ]
        )
    ]
)
