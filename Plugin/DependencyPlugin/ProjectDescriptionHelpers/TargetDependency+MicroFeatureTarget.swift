import Foundation
import ProjectDescription

public extension TargetDependency {
    static func feature(
        target: ModulePaths.Feature,
        type: MicroTargetType = .implement
    ) -> TargetDependency {
        .project(
            target: target.targetName(type: type),
            path: .relativeToFeature(target.rawValue)
        )
    }

    static func domain(
        target: ModulePaths.Domain,
        type: MicroTargetType = .implement
    ) -> TargetDependency {
        .project(
            target: target.targetName(type: type),
            path: .relativeToDomain(target.rawValue)
        )
    }

    static func data(
        target: ModulePaths.Data,
        type: MicroTargetType = .implement
    ) -> TargetDependency {
        .project(
            target: target.targetName(type: type),
            path: .relativeToData(target.rawValue)
        )
    }

    static func shared(
        target: ModulePaths.Shared,
        type: MicroTargetType = .implement
    ) -> TargetDependency {
        .project(
            target: target.targetName(type: type),
            path: .relativeToShared(target.rawValue)
        )
    }

    static func featureInterface(
        target: ModulePaths.FeatureInterface,
        type: MicroTargetType = .implement
    ) -> TargetDependency {
        .project(
            target: target.targetName(type: type),
            path: .relativeToFeatureInterface(target.rawValue)
        )
    }
  
  static func preview(
      target: ModulePaths.Preview,
      type: MicroTargetType = .implement
  ) -> TargetDependency {
      .project(
          target: target.targetName(type: type),
          path: .relativeToPreview(target.rawValue)
      )
  }
}
