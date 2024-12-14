//
//  TextContentReader.swift
//  Feature
//
//  Created by HUNHEE LEE on 29.08.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import ComposableArchitecture
import DesignSystem
import DomainInterface
import SwiftUI

struct TextContentReader: View {
  @Bindable var store: StoreOf<TextContentReaderFeature>
  @Binding var isPresented: Bool
  
  var body: some View {
    GeometryReader { geometry in
      let pages = TextPageCalculator.calculatePages(
        text: store.content.content,
        config: .init(
          pageSize: geometry.size,
          fontSize: CGFloat(store.viewerSettings.fontSize),
          lineSpacing: store.viewerSettings.lineSpacing,
          padding: 20)
      )
      
      TabView {
        ForEach(pages) { page in
          VStack(alignment: .leading) {
            Text(page.content)
              .font(AppFont.pretendard(.regular).of(size: CGFloat(store.viewerSettings.fontSize)))
              .lineSpacing(store.viewerSettings.lineSpacing)
              .padding(.horizontal, 20)
            
            Spacer()
          }
        }
      }
      .tabViewStyle(.page(indexDisplayMode: .never))
      
//      ZStack {
//        ContentReaderScrollView(
//          store: store
//        )
//        .onScroll {
//          toggleOverlayVisiblity(false)
//        }
//        .onTapGesture {
//          toggleOverlayVisiblity()
//        }
//        
//        ContentReaderOverlayView(
//          store: store,
//          isPresented: $isPresented
//        )
//      }
    }
    .statusBar(hidden: true)
    .fullScreenCover(isPresented: $store.state.searchFeature.isVisible) {
      ContentReaderSearch(
        store: store.scope(
          state: \.searchFeature,
          action: \.searchFeature
        )
      )
    }
    .fullScreenCover(isPresented: $store.state.settingsFeature.isVisible) {
      NavigationStack {
        ContentReaderSettings(
          isPresented: true,
          store: store.scope(
            state: \.settingsFeature,
            action: \.settingFeature
          )
        )
      }
    }
  }
  
  private func toggleOverlayVisiblity(_ isVisible: Bool? = nil) {
    guard let isVisible else {
      store.send(.toggleOverlay)
      return
    }
    store.send(.setOverlayVisibility(isVisible))
  }
}
