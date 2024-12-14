//
//  ContentReaderOverlay.swift
//  Feature
//
//  Created by HUNHEE LEE on 4.09.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture

public struct ContentReaderOverlayView: View {
  let toolbarHeight: CGFloat = 64
  let navigatorHeight: CGFloat = 108

  @Bindable var store: StoreOf<TextContentReaderFeature>
  @Binding var isPresented: Bool

  public var body: some View {
    GeometryReader { geometry in
      if store.isOverlayVisible {
        VStack {
          ZStack {
            Rectangle()
              .fill(AppColor.appWhite.swiftUIColor)

            VStack(spacing: 0) {
              VStack(spacing: 0) {
                Spacer()
                HStack(spacing: 0) {
                  Button {
                    isPresented = false
                  } label: {
                    Image(systemName: "xmark")
                      .font(.system(size: 20, weight: .regular))
                      .foregroundStyle(AppColor.appBlack.swiftUIColor)
                  }
                  .frame(width: 30, height: 30)

                  Text("\(store.content.name).txt")
                    .lineLimit(2)
                    .font(AppFont.pretendard(.regular).of(size: 17))
                    .foregroundStyle(AppColor.appBlack.swiftUIColor)
                    .padding(.horizontal, 12)

                  Spacer()

                  Button {
                    store.send(.searchButtonTapped)
                  } label: {
                    Image(systemName: "magnifyingglass")
                      .font(.system(size: 20, weight: .regular))
                      .foregroundStyle(AppColor.appBlack.swiftUIColor)
                  }
                  .frame(width: 30, height: 30)
                  .padding(.trailing, 8)

                  Button {
                    store.send(.textSettingsButtonTapped)
                  } label: {
                    Image(systemName: "textformat")
                      .font(.system(size: 20, weight: .regular))
                      .foregroundStyle(AppColor.appBlack.swiftUIColor)
                  }
                  .frame(width: 30, height: 30)
                }
              }
              .padding(EdgeInsets(top: 0, leading: 16, bottom: 14, trailing: 20))

              Divider()
            }
          }
          .frame(height: toolbarHeight + geometry.safeAreaInsets.top)

          Spacer()

          ZStack {
            Rectangle()
              .fill(AppColor.appWhite.swiftUIColor)

            VStack {
              Divider()

              CustomSlider(
                value: Binding(
                  get: { Double(self.store.state.scrolledId) },
                  set: {
                    self.store.send(.setUpdateSource(.slider))
                    self.store.send(.setScrolledId(Int($0)))
                  }
                ),
                range: 0...Double((store.state.textItemList.count - 1)),
                roundToNearestInt: true
              )
              .tint(AppColor.appPrimary.swiftUIColor)
              .controlSize(.mini)
              .padding(EdgeInsets(top: 18, leading: 22, bottom: 0, trailing: 22))

              Text("\(self.store.state.scrolledId) / \(self.store.state.textItemList.count - 1)")
                .font(AppFont.pretendard(.semiBold).of(size: 14))
                .foregroundStyle(AppColor.appBlack.swiftUIColor)

              Spacer()
            }
          }
          .frame(height: navigatorHeight + geometry.safeAreaInsets.bottom)
        }
        .ignoresSafeArea(.all)
      }
    }
  }
}
