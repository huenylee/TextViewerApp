//
//  LibraryDirectory.swift
//  Feature
//
//  Created by HUNHEE LEE on 24.09.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import ComposableArchitecture
import DomainInterface
import SwiftUI
import DesignSystem

public enum DirectoryType {
  case root
  case sub(FolderItem)
  
  var path: String {
    switch self {
    case .root: return "/"
    case .sub(let folder): return folder.name
    }
  }
  
  var title: String {
    switch self {
    case .root: return "보관함"
    case .sub(let folder): return folder.name
    }
  }
}

public struct LibraryDirectory: View {
  @Bindable var libraryStore: StoreOf<LibraryFeature>
  @Bindable var moreStore: StoreOf<SettingsFeature>
  let currentFolder: DirectoryType
  
  private var directoryFiles: [LibraryItemWrapper] {
    Array(libraryStore.filesByPath[currentFolder.path] ?? [])
  }
  
  public var body: some View {
    Group {
      if !directoryFiles.isEmpty {
        LibraryList(
          files: directoryFiles,
          onContentTapped: { libraryStore.send(.tappedContent($0)) },
          onFolderTapped: { libraryStore.send(.tappedFolder($0)) },
          onActionMenu: { libraryStore.send(.tappedActionMenu) }
        )
      } else {
        VStack(spacing: 0) {
          Image(systemName: "text.book.closed.fill")
            .font(.system(size: 45))
            .foregroundStyle(AppColor.appGray300.swiftUIColor)
            .padding(.bottom, 23)
          
          Text(
          """
            보관함이 비어있어요.
            오른쪽 상단 + 버튼을 눌러서
            파일을 추가해보세요.
          """
          )
          .lineSpacing(3)
          .foregroundStyle(AppColor.appGray700.swiftUIColor)
          .multilineTextAlignment(.center)
        }
      }
    }
    .navigationTitle(currentFolder.title)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button {
          libraryStore.send(.tappedAddButton)
        } label: {
          Image(systemName: "plus")
            .foregroundStyle(AppColor.appBlack.swiftUIColor)
        }
      }
      ToolbarItem(placement: .topBarTrailing) {
        Button {
          moreStore.send(.tappedSettings)
        } label: {
          Image(systemName: "ellipsis")
            .foregroundStyle(AppColor.appBlack.swiftUIColor)
        }
      }
    }
    .onAppear {
      libraryStore.send(.loadDirectory(path: currentFolder.path))
    }
    .sheet(isPresented: $libraryStore.isShowingAddSheet) {
      LibraryItemAdd(store: libraryStore)
        .presentationDetents([.height(160)])
    }
    .sheet(isPresented: $libraryStore.isShowingDocumentPicker) {
      DocumentPicker(fileURL: .constant(nil), contentTypes: [.txt]) { url in
        libraryStore.send(.selectedFile(url))
      }
      .presentationDetents([.large])
      .ignoresSafeArea(.all)
    }
    .sheet(isPresented: $libraryStore.isShowingCreateFolderSheet) {
      AddNewFolder(
        store: libraryStore,
        isPresented: $libraryStore.isShowingCreateFolderSheet
      )
      .presentationDetents([.fraction(0.2)])
    }
    .ignoresSafeArea(.keyboard)
    .sheet(isPresented: $libraryStore.isShowingActionMenu) {
      ActionMenu(
        store: libraryStore
      )
      .presentationDetents([.height(160)])
    }
    .fullScreenCover(isPresented: $libraryStore.isShowingContentReader) {
      libraryStore.presentedContent = nil
    } content: {
      if let state = libraryStore.textContentReader {
        TextContentReader(
          store: libraryStore.scope(
            state: \.textContentReader!,
            action: \.textContentReader
          ),
          isPresented: $libraryStore.isShowingContentReader
        )
      }
    }
  }
}
