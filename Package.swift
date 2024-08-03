// swift-tools-version: 5.10
import PackageDescription

let package = Package(
  name: "openmoonray",
  platforms: [
    .macOS(.v14),
    .visionOS(.v1),
    .iOS(.v17),
    .tvOS(.v17),
    .watchOS(.v10),
  ],
  products: [
    .library(
      name: "OpenMoonRay",
      targets: ["OpenMoonRay"]
    ),
    .library(
      name: "moonray",
      targets: ["moonray"]
    ),
  ],
  targets: [
    .target(
      name: "moonray",
      path: "moonray/moonray",
      exclude: [
        "cmd",
        "lib/application",
        "moonray/application",
        "tests"
      ],
      cxxSettings: [
        .define("_ALLOW_COMPILER_AND_STL_VERSION_MISMATCH", .when(platforms: [.windows]))
      ]
    ),
    .target(
      name: "OpenMoonRay",
      dependencies: [
        .target(name: "moonray")
      ],
      cxxSettings: [
        .define("_ALLOW_COMPILER_AND_STL_VERSION_MISMATCH", .when(platforms: [.windows]))
      ],
      swiftSettings: [
        .interoperabilityMode(.Cxx)
      ]
    ),
    .testTarget(
      name: "OpenMoonRayTests",
      dependencies: ["OpenMoonRay"],
      cxxSettings: [
        .define("_ALLOW_COMPILER_AND_STL_VERSION_MISMATCH", .when(platforms: [.windows]))
      ],
      swiftSettings: [
        .interoperabilityMode(.Cxx)
      ]
    ),
  ],
  cLanguageStandard: .gnu17,
  cxxLanguageStandard: .cxx17
)
