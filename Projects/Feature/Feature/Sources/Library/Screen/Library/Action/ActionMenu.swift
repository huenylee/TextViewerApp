//
//  ActionMenu.swift
//  Feature
//
//  Created by HUNHEE LEE on 15.11.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture

struct ActionMenu: View {
  let store: StoreOf<LibraryFeature>
  
  var body: some View {
    BottomSheet {
      SheetItemList {
        SheetItemList.Item(
          imageName: "pencil.line",
          title: "이름 수정"
        ) {
          print("새 폴더 생성")
        }
        
        SheetItemList.Item(
          imageName: "trash",
          title: "삭제"
        ) {
          print("삭제")
        }
      }
    }
  }
}
