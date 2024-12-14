//
//  LibraryItemWrapper.swift
//  Domain
//
//  Created by HUNHEE LEE on 27.08.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import Foundation

public struct LibraryItemWrapper: Hashable, Identifiable {
  public let id: UUID = UUID()
  private let _hash: (inout Hasher) -> Void
  private let _equals: (Any) -> Bool

  public let file: any LibraryItem

  public init<T: LibraryItem & Hashable>(_ file: T) {
    self.file = file
    self._hash = { hasher in
      file.hash(into: &hasher)
    }
    self._equals = { other in
      guard let otherItem = other as? T else { return false }
      return file == otherItem
    }
  }

  public func hash(into hasher: inout Hasher) {
    _hash(&hasher)
  }

  public static func == (lhs: LibraryItemWrapper, rhs: LibraryItemWrapper) -> Bool {
    lhs._equals(rhs.file)
  }
}

public extension LibraryItemWrapper {
  var asFolder: FolderItem? {
    file as? FolderItem
  }
  
  var asContent: ContentItem? {
    file as? ContentItem
  }
}
