//
//  Untitled.swift
//  Data
//
//  Created by HUNHEE LEE on 24.09.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import Foundation

public struct FileInfo {
  let name: String
  let isDirectory: Bool
  let fileSize: Int64?
  let creationDate: Date?
  let modificationDate: Date?
  let fileExtension: String
  let numberOfItems: Int?
  let data: Data?
  let path: String
  
  public init(name: String, isDirectory: Bool, fileSize: Int64?, creationDate: Date?, modificationDate: Date?, fileExtension: String, numberOfItems: Int?, data: Data?, path: String) {
    self.name = name
    self.isDirectory = isDirectory
    self.fileSize = fileSize
    self.creationDate = creationDate
    self.modificationDate = modificationDate
    self.fileExtension = fileExtension
    self.numberOfItems = numberOfItems
    self.data = data
    self.path = path
  }
}

public extension FileInfo {
  func todomain() -> (any LibraryItem)? {
    guard let creationDate else { return nil }
    if isDirectory {
      guard let numberOfItems else { return nil }
      return FolderItem(
        name: name,
        createdDate: creationDate,
        subfilesCount: numberOfItems,
        path: path
      )
    } else {
      guard let type = ContentItemType(rawValue: fileExtension) else { return nil }
      guard let fileSize else { return nil }
      guard let data else { return nil }
      return ContentItem(
        name: name,
        createdDate: creationDate,
        fileSize: fileSize,
        type: .content(type),
        content: String(data: data, encoding: .utf8) ?? "",
        path: path
      )
    }
  }
}
