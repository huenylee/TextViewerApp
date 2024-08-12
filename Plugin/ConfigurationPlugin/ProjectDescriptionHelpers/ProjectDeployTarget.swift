import Foundation
import ProjectDescription

public enum ProjectDeployTarget: String {
    case dev = "dev"
    case stage = "stage"
    case prod = "prod"

    public var configurationName: ConfigurationName {
        ConfigurationName.configuration(self.rawValue)
    }
}
