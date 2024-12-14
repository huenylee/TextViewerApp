//
//  TextViewerApp.swift
//  TextViewerApp
//
//  Created by HUNHEE LEE on 27.08.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import Feature
import SwiftUI
import ComposableArchitecture
import SwiftData
import Data

@main
struct TextViewerApp: App {
  let appDependency: AppDependency = .live
  
  var body: some Scene {
    WindowGroup {
      MainView(
        libraryStore: appDependency.makeLibraryFeatureStore(),
        moreStore: appDependency.makeMoreFeatureStore()
      )
    }
  }
}
