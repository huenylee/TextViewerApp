//
//  LibraryFileRow.swift
//  Feature
//
//  Created by HUNHEE LEE on 26.08.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import Domain
import DomainInterface
import DesignSystem
import SwiftUI

public struct LibraryContentRow: View {
  let content: ContentItem
  var onTapped: () -> Void?
  var onLongTapped: () -> Void?

  public var body: some View {
    ZStack {
      AppColor.appWhite.swiftUIColor
      HStack(spacing: 0) {
        Image(systemName: "doc.text.fill")
          .resizable()
          .scaledToFit()
          .frame(width: 20)
          .foregroundStyle(AppColor.appGray700.swiftUIColor)
          .padding(.trailing, 18)
        VStack(alignment: .leading, spacing: 0) {
          Text(content.name)
            .lineLimit(2)
            .font(AppFont.pretendard(.regular).of(size: 16))
            .foregroundStyle(AppColor.appBlack.swiftUIColor)
            .padding(.bottom, 5)
          HStack {
            Text(content.createdDate.formatted(.dotted))
              .font(AppFont.pretendard(.regular).of(size: 14))
              .foregroundStyle(AppColor.appGray500.swiftUIColor)
            Text(content.fileSize.toFileSize())
              .font(AppFont.pretendard(.regular).of(size: 14))
              .foregroundStyle(AppColor.appGray500.swiftUIColor)
          }
        }
        Spacer()
      }
      .padding(.vertical, 17)
    }
    .padding(.horizontal, 20)
    .pressableWithTapGesture {
      onTapped()
    }
    .onLongPressGesture {
      onLongTapped()
    }
  }
}
