//
//  SettingsFeature.swift
//  Feature
//
//  Created by HUNHEE LEE on 19.11.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import ComposableArchitecture
import Foundation
import SwiftUI
import DomainInterface

@Reducer
public struct SettingsFeature {
  private let updateViewerSettingsUseCase: UpdateViewerSettingsUseCase
  private let fetchViewerSettingsUseCase: FetchViewerSettingsUseCase
  
  public init(
    updateViewerSettingsUseCase: UpdateViewerSettingsUseCase,
    fetchViewerSettingsUseCase: FetchViewerSettingsUseCase
  ) {
    self.updateViewerSettingsUseCase = updateViewerSettingsUseCase
    self.fetchViewerSettingsUseCase = fetchViewerSettingsUseCase
  }
  
  @ObservableState
  public struct State: Equatable {
    var path: NavigationPath
    
    var isShowingSettings: Bool = false
    var viewerSettings: TextContentReaderSettingsFeature.State
    
    public init(
      path: NavigationPath = NavigationPath(),
      viewerSettings: TextContentReaderSettingsFeature.State
    ) {
      self.path = path
      self.viewerSettings = viewerSettings
    }
  }
  
  public enum Action: BindableAction {
    case navigationBack
    case tappedSettings
    case viewerSettings(TextContentReaderSettingsFeature.Action)
    case binding(BindingAction<State>)
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .navigationBack:
        state.isShowingSettings = false
        return .none
      case .binding:
        return .none
      case .tappedSettings:
        let settings = fetchViewerSettingsUseCase.execute()
        state.viewerSettings = TextContentReaderSettingsFeature.State(settings: settings)
        state.isShowingSettings = true
        return .none
      case .viewerSettings:
        return .none
      }
    }
    Scope(state: \.viewerSettings, action: \.viewerSettings) {
      TextContentReaderSettingsFeature(
        updateViewerSettingsUseCase: updateViewerSettingsUseCase
      )
    }
  }
}
