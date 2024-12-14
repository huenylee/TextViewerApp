import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
  name: ModulePaths.FeatureInterface.DesignSystem.rawValue,
  targets: [
    .implements(
      module: .featureInferface(.DesignSystem),
      product: .staticFramework,
      spec: TargetSpec(
        sources: .sources,
        resources: ["Resources/**"],
        dependencies: [
          .shared(target: .Shared)
        ]
      )
    ),
    .example(
      module: .featureInferface(.DesignSystem),
      dependencies: [
        .featureInterface(target: .DesignSystem),
      ]
    )
  ],
  resourceSynthesizers: [
    .strings(),
    .assets(),
    .fonts()
  ]
)
