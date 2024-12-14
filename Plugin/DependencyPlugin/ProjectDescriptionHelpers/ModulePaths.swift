import Foundation

// swiftlint: disable all
public enum ModulePaths {
  case preview(Preview)
  case feature(Feature)
  case domain(Domain)
  case data(Data)
  case shared(Shared)
  case featureInferface(FeatureInterface)
}

extension ModulePaths: MicroTargetPathConvertable {
  public func targetName(type: MicroTargetType) -> String {
    switch self {
    case let .feature(module as any MicroTargetPathConvertable),
         let .domain(module as any MicroTargetPathConvertable),
         let .data(module as any MicroTargetPathConvertable),
         let .shared(module as any MicroTargetPathConvertable),
         let .featureInferface(module as any MicroTargetPathConvertable),
         let .preview(module as any MicroTargetPathConvertable):
      return module.targetName(type: type)
    }
  }
}

public extension ModulePaths {
  enum Preview: String, MicroTargetPathConvertable {
    case Preview
  }
}

public extension ModulePaths {
  enum Feature: String, MicroTargetPathConvertable {
    case Feature
  }
}

public extension ModulePaths {
  enum Domain: String, MicroTargetPathConvertable {
    case Domain
  }
}

public extension ModulePaths {
  enum Data: String, MicroTargetPathConvertable {
    case Data
  }
}

public extension ModulePaths {
  enum Shared: String, MicroTargetPathConvertable {
    case GlobalThirdPartyLibrary
    case Shared
  }
}

public extension ModulePaths {
  enum FeatureInterface: String, MicroTargetPathConvertable {
    case DesignSystem
  }
}

public enum MicroTargetType: String {
  case interface = "Interface"
  case implement = ""
  case testing = "Testing"
  case unitTest = "Tests"
  case example = "Example"
}

public protocol MicroTargetPathConvertable {
  func targetName(type: MicroTargetType) -> String
}

public extension MicroTargetPathConvertable where Self: RawRepresentable {
  func targetName(type: MicroTargetType) -> String {
    "\(self.rawValue)\(type.rawValue)"
  }
}
