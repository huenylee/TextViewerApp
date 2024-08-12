//
//  Project.swift
//  Config
//
//  Created by HUNHEE LEE on 12.08.2024.
//

import ConfigurationPlugin
import DependencyPlugin
import EnvironmentPlugin
import Foundation
import ProjectDescription
import ProjectDescriptionHelpers

let configuration: [Configuration] = .default

let settings: Settings = .settings(
  base: env.baseSetting,
  configurations: configuration,
  defaultSettings: .recommended
)

let scripts: [TargetScript] = generateEnvironment.scripts

let targets: [Target] = [
  .target(
    name: env.name,
    destinations: env.destinations,
    product: .app,
    bundleId: "\(env.organizationName).\(env.name)",
    deploymentTargets: env.deploymentTargets,
    infoPlist: .file(path: "Support/Info.plist"),
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    scripts: scripts,
    dependencies: [
      .feature(target: .BaseFeature),
      .data(target: .BaseData)
    ],
    settings: .settings(base: env.baseSetting)
  )
]

let schemes: [Scheme] = [
  .scheme(
    name: "\(env.name)-dev",
    shared: true,
    buildAction: .buildAction(targets: ["\(env.name)"]),
    runAction: .runAction(configuration: .dev),
    archiveAction: .archiveAction(configuration: .dev),
    profileAction: .profileAction(configuration: .dev),
    analyzeAction: .analyzeAction(configuration: .dev)
  ),
  .scheme(
    name: "\(env.name)-stage",
    shared: true,
    buildAction: .buildAction(targets: ["\(env.name)"]),
    runAction: .runAction(configuration: .stage),
    archiveAction: .archiveAction(configuration: .stage),
    profileAction: .profileAction(configuration: .stage),
    analyzeAction: .analyzeAction(configuration: .stage)
  ),
  .scheme(
    name: "\(env.name)-prod",
    shared: true,
    buildAction: .buildAction(targets: ["\(env.name)"]),
    runAction: .runAction(configuration: .prod),
    archiveAction: .archiveAction(configuration: .prod),
    profileAction: .profileAction(configuration: .prod),
    analyzeAction: .analyzeAction(configuration: .prod)
  )
]

let project = Project(
  name: env.name,
  organizationName: env.organizationName,
  settings: settings,
  targets: targets
)
