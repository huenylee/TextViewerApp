import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
  name: ModulePaths.Domain.Domain.rawValue,
  targets: [
    .implements(
      module: .domain(.Domain),
      product: .staticFramework,
      dependencies: [
        .domain(target: .Domain, type: .interface)
      ]
    ),
    .interface(
      module: .domain(.Domain),
      spec: .init(
        product: .staticFramework,
        dependencies: [
          .shared(target: .Shared),
          .shared(target: .GlobalThirdPartyLibrary)
        ]
      )
    ),
    .tests(
      module: .domain(.Domain),
      dependencies: [
        .domain(target: .Domain)
      ]
    )
  ]
)
