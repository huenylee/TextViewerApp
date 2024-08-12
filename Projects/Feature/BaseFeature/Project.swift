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
  name: ModulePaths.Feature.BaseFeature.rawValue,
  targets: [
    .implements(
      module: .feature(
        .BaseFeature
      ),
      product: isPreview ? .framework : .staticFramework,
      dependencies: [
        .domain(target: .BaseDomain),
        .featureInterface(target: .DesignSystem)
      ]
    ),
    .tests(
      module: .feature(.BaseFeature),
      dependencies: [
        .feature(target: .BaseFeature)
      ]
    ),
    .implements(
      module: .preview(.Preview),
      product: .framework,
      dependencies: [
        .feature(target: .BaseFeature)
      ]
    )
  ]
)
