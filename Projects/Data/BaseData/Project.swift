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
  name: ModulePaths.Data.BaseData.rawValue,
  targets: [
    .implements(
      module: .data(.BaseData),
      product: .framework,
      dependencies: [
        .domain(target: .BaseDomain)
      ]
    ),
    .tests(
      module: .data(.BaseData),
      dependencies: [
        .data(target: .BaseData)
      ]
    )
  ]
)
