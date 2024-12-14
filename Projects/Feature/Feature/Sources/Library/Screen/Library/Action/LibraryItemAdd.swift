//
//  LibraryItemAdd.swift
//  Feature
//
//  Created by HUNHEE LEE on 28.08.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture

struct LibraryItemAdd: View {
  let store: StoreOf<LibraryFeature>
  
  var body: some View {
    BottomSheet {
      SheetItemList {
        SheetItemList.Item(
          imageName: "icloud.and.arrow.down",
          title: "다운로드"
        ) {
          store.send(.tappedDownloadFile)
        }
        
        SheetItemList.Item(
          imageName: "folder.badge.plus",
          title: "폴더 생성"
        ) {
          store.send(.tappedCreateFolder)
        }
      }
    }
  }
}
