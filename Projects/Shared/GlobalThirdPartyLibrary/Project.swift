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
  name: ModulePaths.Shared.GlobalThirdPartyLibrary.rawValue,
  targets: [
    .implements(
      module: .shared(.GlobalThirdPartyLibrary),
      product: .staticFramework,
      dependencies: [
        .external(name: "ComposableArchitecture")
      ]
    )
  ]
)
