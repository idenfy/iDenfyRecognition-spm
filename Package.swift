// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let version = "8.1.1"

enum Checksums {
    static let iDenfyInternalLoggerChecksum = "5afd4977948bc0611cdf20dc533582047cf454c34eb59bcbb642f3670229cb4f"
    static let iDenfyDocRecognitionChecksum = "95aefa43f2af210f14a15e291dc920a862cef25cc8fd5ea016f0cf8a56ec8dd8"
    static let idengineChecksum = "4453ddef87ac3055ba720a751f07932505225fbfad772519a78b4c3bffa1913c"
    static let FaceTecSDKChecksum = "b42aaf7b9f6e890e9b75820447d12c7cc1c7611b58b3b25bda13ef947ca9f5ec"
    static let iDenfyLivenessChecksum = "adf9b9a71b3eab780d46ce2d7466d13f1d2f6dbfb4f916c1944ae2114dd81a08"
    static let idenfyviewsChecksum = "8592c6cf253275fe005ccd19f950e3b08de436ca1904ec3ac6c316e26ec640b7"
    static let iDenfySDKChecksum = "3916b2bfd2682028bbcb18a540a659cdaf6ec970af520707716b9e7130b66c59"
    static let idenfycoreChecksum = "fd5f063df9ea408baed8b578643d939b0112e0e687d22c004c3aba4e2f08e1d3"
    static let idenfyNFCReadingChecksum = "75ea3dbbab11d7433a0afd89c89637cfe21b922668483cc765885d6be8935e2b"
    static let openSSLChecksum = "732d36cd059bb58e0dafce4a129939200a6e381f02cbd7014d63e70b5134671e"
}

let package = Package(
    name: "iDenfyRecognition",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "iDenfyRecognition-Dynamic",
            type: .dynamic,
            targets: ["iDenfySDKTarget"]),
        .library(
            name: "iDenfyRecognition",
            targets: ["iDenfySDKTarget"]),
    ],
    dependencies: [
        .package(url: "https://github.com/airbnb/lottie-spm.git", "4.2.0"..<"4.2.1"),
    ],
    targets: [
        //IdenfyViews
        .target(
            name: "idenfyviewsTarget",
            dependencies: [.target(name: "idenfyviewsWrapper",
                                   condition: .when(platforms: [.iOS]))],
            path: "SwiftPM-PlatformExclude/idenfyviewsWrap"
        ),
        .target(
            name: "idenfyviewsWrapper",
            dependencies: [
                .target(
                    name: "idenfyviews",
                    condition: .when(platforms: [.iOS])
                ),
                .target(name: "idenfycore",
                        condition: .when(platforms: [.iOS])),
                .product(name: "Lottie",
                         package: "lottie-spm",
                         condition: .when(platforms: [.iOS])),
            ],
            path: "idenfyviewsWrapper"
        ),
        //IdenfyNFCReading
        .target(
            name: "idenfyNFCReadingTarget",
            dependencies: [.target(name: "idenfyNFCReadingWrapper",
                                   condition: .when(platforms: [.iOS]))],
            path: "SwiftPM-PlatformExclude/idenfyNFCReadingWrap"
        ),
        .target(
            name: "idenfyNFCReadingWrapper",
            dependencies: [
                .target(
                    name: "idenfyNFCReading",
                    condition: .when(platforms: [.iOS])
                ),
                .target(name: "OpenSSL",
                        condition: .when(platforms: [.iOS])),
            ],
            path: "idenfyNFCReadingWrapper"
        ),
        //IdenfyLiveness
        .target(
            name: "IdenfyLivenessTarget",
            dependencies: [.target(name: "IdenfyLivenessWrapper",
                                   condition: .when(platforms: [.iOS]))],
            path: "SwiftPM-PlatformExclude/IdenfyLivenessWrap"
        ),
        .target(
            name: "IdenfyLivenessWrapper",
            dependencies: [
                .target(
                    name: "IdenfyLiveness",
                    condition: .when(platforms: [.iOS])
                ),
                .target(name: "FaceTecSDK",
                        condition: .when(platforms: [.iOS])),
                .target(name: "idenfyviewsTarget",
                        condition: .when(platforms: [.iOS])),
                .target(name: "idenfycore",
                        condition: .when(platforms: [.iOS])),
            ],
            path: "IdenfyLivenessWrapper"
        ),
        //IdenfyRecognition
        .target(
            name: "iDenfyDocRecognitionTarget",
            dependencies: [.target(name: "iDenfyDocRecognitionWrapper",
                                   condition: .when(platforms: [.iOS]))],
            path: "SwiftPM-PlatformExclude/iDenfyDocRecognitionWrap"
        ),
        .target(
            name: "iDenfyDocRecognitionWrapper",
            dependencies: [
                .target(
                    name: "iDenfyDocRecognition",
                    condition: .when(platforms: [.iOS])
                ),
            ],
            path: "iDenfyDocRecognitionWrapper"
        ),
        //iDenfySDK
        .target(
            name: "iDenfySDKTarget",
            dependencies: [.target(name: "iDenfySDKWrapper",
                                   condition: .when(platforms: [.iOS]))],
            path: "SwiftPM-PlatformExclude/iDenfySDKWrap",
            cSettings: [
                .define("CLANG_MODULES_AUTOLINK", to: "YES"),
                .define("OTHER_LDFLAGS[sdk=iphoneos*]", to: "-ObjC -l\"idengine-ios\""),
                .define("OTHER_LDFLAGS[sdk=iphonesimulator*]", to: "-ObjC -l\"idengine-ios-simulator\""),
                .define("EXCLUDED_ARCHS[sdk=iphonesimulator*]", to: "i386"),
            ]
        ),
        .target(
            name: "iDenfySDKWrapper",
            dependencies: [
                .target(
                    name: "iDenfySDK",
                    condition: .when(platforms: [.iOS])),
                .product(name: "Lottie",
                         package: "lottie-spm",
                         condition: .when(platforms: [.iOS])),
                .target(name: "idenfycore",
                        condition: .when(platforms: [.iOS])),
                .target(name: "iDenfyInternalLogger",
                        condition: .when(platforms: [.iOS])),
                .target(name: "idenfyNFCReadingTarget",
                        condition: .when(platforms: [.iOS])),
                .target(name: "idenfyviewsTarget",
                        condition: .when(platforms: [.iOS])),
                .target(name: "FaceTecSDK",
                        condition: .when(platforms: [.iOS])),
                .target(name: "IdenfyLivenessTarget",
                        condition: .when(platforms: [.iOS])),
                .target(name: "iDenfyDocRecognitionTarget",
                        condition: .when(platforms: [.iOS])),
                .target(name: "idengine",
                        condition: .when(platforms: [.iOS])),
            ],
            path: "iDenfySDKWrapper"
        ),
        // Binaries
        .binaryTarget(name: "iDenfyInternalLogger",
                      url: "https://s3.eu-west-1.amazonaws.com/sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/iDenfyInternalLogger.zip", checksum: Checksums.iDenfyInternalLoggerChecksum),
        .binaryTarget(name: "iDenfyDocRecognition",
                      url: "https://s3.eu-west-1.amazonaws.com/sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/iDenfyDocRecognition.zip", checksum: Checksums.iDenfyDocRecognitionChecksum),
        .binaryTarget(name: "idengine",
                      url: "https://s3.eu-west-1.amazonaws.com/sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/idengine.zip", checksum: Checksums.idengineChecksum),
        .binaryTarget(name: "FaceTecSDK",
                      url: "https://s3.eu-west-1.amazonaws.com/sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/FaceTecSDK.zip", checksum: Checksums.FaceTecSDKChecksum),
        .binaryTarget(name: "IdenfyLiveness",
                      url: "https://s3.eu-west-1.amazonaws.com/sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/IdenfyLiveness.zip", checksum: Checksums.iDenfyLivenessChecksum),
        .binaryTarget(name: "idenfyviews",
                      url: "https://s3.eu-west-1.amazonaws.com/sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/idenfyviews.zip", checksum: Checksums.idenfyviewsChecksum),
        .binaryTarget(name: "iDenfySDK",
                      url: "https://s3.eu-west-1.amazonaws.com/sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/iDenfySDK.zip", checksum: Checksums.iDenfySDKChecksum),
        .binaryTarget(name: "idenfycore",
                      url: "https://s3.eu-west-1.amazonaws.com/sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/idenfycore.zip", checksum: Checksums.idenfycoreChecksum),
        .binaryTarget(name: "idenfyNFCReading",
                      url: "https://s3.eu-west-1.amazonaws.com/sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/idenfyNFCReading.zip", checksum: Checksums.idenfyNFCReadingChecksum),
        .binaryTarget(name: "OpenSSL",
                      url: "https://s3.eu-west-1.amazonaws.com/sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/OpenSSL.zip", checksum: Checksums.openSSLChecksum),
    ]
)
