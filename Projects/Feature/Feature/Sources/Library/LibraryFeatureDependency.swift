//
//  LibraryFeatureDependency.swift
//  Feature
//
//  Created by HUNHEE LEE on 27.08.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import Domain
import DomainInterface

public struct LibraryFeatureDependency {
  public let fetchFileListUseCase: FetchFileListUseCase
  public let downloadFileUseCase: DownloadFileUseCase
  public let createFolderUseCase: CreateFolderUseCase
  public let fetchViewerSettingsUseCase: FetchViewerSettingsUseCase
  public let updateViewerSettingsUseCase: UpdateViewerSettingsUseCase

  public init(
    fetchFileListUseCase: FetchFileListUseCase,
    downloadFileUseCase: DownloadFileUseCase,
    createFolderUseCase: CreateFolderUseCase,
    fetchViewerSettingsUseCase: FetchViewerSettingsUseCase,
    updateViewerSettingsUseCase: UpdateViewerSettingsUseCase
  ) {
    self.fetchFileListUseCase = fetchFileListUseCase
    self.downloadFileUseCase = downloadFileUseCase
    self.createFolderUseCase = createFolderUseCase
    self.fetchViewerSettingsUseCase = fetchViewerSettingsUseCase
    self.updateViewerSettingsUseCase = updateViewerSettingsUseCase
  }
}
