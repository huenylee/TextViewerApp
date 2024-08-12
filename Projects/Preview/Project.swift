//
//  Project.swift
//  AppManifests
//
//  Created by HUNHEE LEE on 12.08.2024.
//

import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
  name: ModulePaths.Preview.Preview.rawValue,
  targets: [
    .implements(
      module: .preview(.Preview),
      product: .framework,
      dependencies: [
        .feature(target: .BaseFeature)
      ]
    )
  ]
)
