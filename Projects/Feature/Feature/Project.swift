//
//  Project.swift
//  AppManifests
//
//  Created by HUNHEE LEE on 12.08.2024.
//

import DependencyPlugin
import EnvironmentPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
  name: ModulePaths.Feature.Feature.rawValue,
  targets: [
    .implements(
      module: .feature(
        .Feature
      ),
      product: isPreview ? .framework : .staticFramework,
      dependencies: [
        .domain(target: .Domain),
        .featureInterface(target: .DesignSystem)
      ]
    ),
    .tests(
      module: .feature(.Feature),
      dependencies: [
        .feature(target: .Feature)
      ]
    )
  ]
)
