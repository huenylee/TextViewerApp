//
//  LibraryList.swift
//  Feature
//
//  Created by HUNHEE LEE on 27.08.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import DomainInterface
import SwiftUI

public struct LibraryList: View {
  let files: [LibraryItemWrapper]
  var onContentTapped: (ContentItem) -> Void
  var onFolderTapped: (FolderItem) -> Void
  var onActionMenu: () -> Void

  public var body: some View {
    List {
      ForEach(files) { file in
        VStack(spacing: 0) {
          if let folder = file.asFolder {
            LibraryFolderRow(folder: folder) {
              onFolderTapped(folder)
            } onLongTapped: {
              onActionMenu()
            }
          } else if let content = file.asContent {
            LibraryContentRow(content: content) {
              onContentTapped(content)
            } onLongTapped: {
              onActionMenu()
            }
          }

          Divider()
        }
        .frame(height: 85)
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
      }
    }
    .listStyle(.plain)
  }
}
