//
//  LibraryFolderRow.swift
//  Feature
//
//  Created by HUNHEE LEE on 26.08.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import Domain
import DomainInterface
import ComposableArchitecture
import DesignSystem
import SwiftUI

public struct LibraryFolderRow: View {
  let folder: FolderItem
  var onTapped: () -> Void?
  var onLongTapped: () -> Void?

  public var body: some View {
    ZStack {
      AppColor.appWhite.swiftUIColor
      HStack(spacing: 0) {
        Image(systemName: "folder.fill")
          .resizable()
          .scaledToFit()
          .frame(width: 20)
          .foregroundStyle(AppColor.appSecondary.swiftUIColor)
          .padding(.trailing, 18)
        VStack(alignment: .leading, spacing: 0) {
          Text(folder.name)
            .lineLimit(2)
            .font(AppFont.pretendard(.regular).of(size: 16))
            .foregroundStyle(AppColor.appBlack.swiftUIColor)
            .padding(.bottom, 5)
          HStack {
            Text(folder.createdDate.formatted(.dotted))
              .font(AppFont.pretendard(.regular).of(size: 14))
              .foregroundStyle(AppColor.appGray500.swiftUIColor)
            Text("파일 \(folder.subfilesCount)개")
              .font(AppFont.pretendard(.regular).of(size: 14))
              .foregroundStyle(AppColor.appGray500.swiftUIColor)
          }
        }
        Spacer()
        Image(asset: AppImage.arrowRight)
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
