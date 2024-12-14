//
//  MainView.swift
//  Feature
//
//  Created by HUNHEE LEE on 12.08.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct MainView: View {
  let libraryStore: StoreOf<LibraryFeature>
  let moreStore: StoreOf<SettingsFeature>
  
  public var body: some View {
    Library(
      libraryStore: libraryStore,
      moreStore: moreStore
    )
    .toolbar(.hidden, for: .navigationBar)
  }

  public init(
    libraryStore: StoreOf<LibraryFeature>,
    moreStore: StoreOf<SettingsFeature>
  ) {
    self.libraryStore = libraryStore
    self.moreStore = moreStore
  }
}
