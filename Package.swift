// swift-tools-version: 5.9
@preconcurrency import PackageDescription

#if TUIST
import ProjectDescription
import ProjectDescriptionHelpers

let packageSetting = PackageSettings(
  baseSettings: .settings(
    configurations: [
      .debug(name: .dev),
      .debug(name: .stage),
      .release(name: .prod)
    ]
  )
)
#endif

let package = Package(
  name: "MyTextViewer",
  platforms: [
    .iOS(.v17)
  ],
  dependencies: [
    .package(
      url: "https://github.com/pointfreeco/swift-composable-architecture.git",
      .upToNextMinor(from: "1.13.0")
    )
  ]
)
