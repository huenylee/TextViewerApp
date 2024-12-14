//
//  NavigationBar.swift
//  DesignSystem
//
//  Created by HUNHEE LEE on 20.11.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import SwiftUI

public struct NavigationBar: View {
  let title: String
  let topInset: CGFloat
  let onDismiss: () -> Void
  
  private let toolbarHeight: CGFloat = 56
  
  public init(
    title: String,
    topInset: CGFloat,
    onDismiss: @escaping () -> Void
  ) {
    self.title = title
    self.topInset = topInset
    self.onDismiss = onDismiss
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      VStack(spacing: 0) {
        Spacer()
        ZStack {
          Text(title)
            .lineLimit(2)
            .font(AppFont.pretendard(.semiBold).of(size: 18))
            .foregroundStyle(AppColor.appBlack.swiftUIColor)
          
          HStack {
            Button {
              onDismiss()
            } label: {
              Image(systemName: "xmark")
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(AppColor.appBlack.swiftUIColor)
            }
            .frame(width: 30, height: 30)
            Spacer()
          }
        }
      }
      .padding(EdgeInsets(top: 0, leading: 16, bottom: 14, trailing: 20))
      
      Divider()
    }
    .frame(height: toolbarHeight + topInset)
  }
}
