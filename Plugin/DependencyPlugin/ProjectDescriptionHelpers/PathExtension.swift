import ProjectDescription

public extension ProjectDescription.Path {
  static func relativeToSections(_ path: String) -> Self {
    return .relativeToRoot("Projects/\(path)")
  }

  static func relativeToFeature(_ path: String) -> Self {
    return .relativeToRoot("Projects/Feature/\(path)")
  }

  static func relativeToDomain(_ path: String) -> Self {
    return .relativeToRoot("Projects/Domain/\(path)")
  }

  static func relativeToData(_ path: String) -> Self {
    return .relativeToRoot("Projects/Data/\(path)")
  }

  static func relativeToShared(_ path: String) -> Self {
    return .relativeToRoot("Projects/Shared/\(path)")
  }

  static func relativeToFeatureInterface(_ path: String) -> Self {
    return .relativeToRoot("Projects/FeatureInterface/\(path)")
  }

  static func relativeToPreview(_ path: String) -> Self {
    return .relativeToRoot("Projects/\(path)")
  }

  static var app: Self {
    return .relativeToRoot("Projects/App")
  }
}

public extension TargetDependency {
  static func feature(name: String) -> Self {
    return .project(target: name, path: .relativeToFeature(name))
  }

  static func domain(name: String) -> Self {
    return .project(target: name, path: .relativeToDomain(name))
  }

  static func data(name: String) -> Self {
    return .project(target: name, path: .relativeToData(name))
  }

  static func shared(name: String) -> Self {
    return .project(target: name, path: .relativeToShared(name))
  }

  static func featureInterface(name: String) -> Self {
    return .project(target: name, path: .relativeToFeatureInterface(name))
  }
}
