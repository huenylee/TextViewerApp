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
  name: ModulePaths.Data.Data.rawValue,
  targets: [
    .implements(
      module: .data(.Data),
      product: .staticFramework,
      dependencies: [
        .domain(target: .Domain)
      ]
    ),
    .tests(
      module: .data(.Data),
      dependencies: [
        .data(target: .Data)
      ]
    )
  ]
)
