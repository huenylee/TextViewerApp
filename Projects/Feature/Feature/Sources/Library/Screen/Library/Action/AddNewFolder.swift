//
//  AddNewFolder.swift
//  Feature
//
//  Created by HUNHEE LEE on 30.08.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import DesignSystem
import SwiftUI
import ComposableArchitecture
import Combine

struct AddNewFolder: View {
  let store: StoreOf<LibraryFeature>
  
  @Binding var isPresented: Bool
  @State private var text: String = ""
  @FocusState public var isTextFieldFocused: Bool
  
  var body: some View {
    VStack(spacing: 0) {
      ZStack {
        Text("폴더 생성")
          .font(AppFont.pretendard(.semiBold).of(size: 16))
        
        HStack {
          Spacer()
          
          Button(action: {
            store.send(.createFolder(folderName: text))
            isPresented = false
          }, label: {
            Text("생성")
              .font(AppFont.pretendard(.semiBold).of(size: 16))
              .foregroundStyle(text.isEmpty ? AppColor.appGray300.swiftUIColor : AppColor.appPrimary.swiftUIColor)
          })
          .disabled(text.isEmpty)
        }
      }
      .padding(.vertical, 17)
      .padding(.horizontal, 19)
      
      Divider()
        .frame(height: 1)
        .foregroundStyle(AppColor.appGray100.swiftUIColor)
      
      TextField("폴더 이름을 입력하세요.", text: $text)
        .focused($isTextFieldFocused)
        .padding(.horizontal, 20)
        .padding(.vertical, 27)
        .scrollDismissesKeyboard(.never)
      
      Spacer()
    }
    .task {
      self.isTextFieldFocused = true
    }
    .ignoresSafeArea(.keyboard, edges: .bottom)
  }
}
