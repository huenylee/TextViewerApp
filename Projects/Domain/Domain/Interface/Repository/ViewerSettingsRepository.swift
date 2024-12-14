//
//  ViewerSettingsRepository.swift
//  Domain
//
//  Created by HUNHEE LEE on 12.12.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

public protocol ViewerSettingsRepository {
  func getSettings() -> ViewerSettings
  func saveSettings(_ settings: ViewerSettings)
}
