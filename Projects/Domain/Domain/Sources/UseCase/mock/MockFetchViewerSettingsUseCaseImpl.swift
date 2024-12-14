//
//  MockFetchViewerSettingsUseCaseImpl.swift
//  Domain
//
//  Created by HUNHEE LEE on 12.12.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import DomainInterface

public struct MockFetchViewerSettingsUseCaseImpl: FetchViewerSettingsUseCase {
  public init() { }
  
  var mockSettings: ViewerSettings = ViewerSettings(
    fontSize: 16,
    lineHeight: 16
  )
   
  public func execute() -> ViewerSettings {
       return mockSettings
   }
}
