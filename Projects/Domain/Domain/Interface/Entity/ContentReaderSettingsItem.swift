//
//  ContentReaderSettingsItem.swift
//  DomainInterface
//
//  Created by HUNHEE LEE on 23.09.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import Foundation

public struct ContentReaderSettingsItem: Equatable {
  let textSize: Int
  
  static public func == (lhs: ContentReaderSettingsItem, rhs: ContentReaderSettingsItem) -> Bool {
    lhs.textSize == rhs.textSize
  }
}
