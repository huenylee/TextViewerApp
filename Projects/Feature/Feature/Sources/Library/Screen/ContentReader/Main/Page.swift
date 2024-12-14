//
//  Page.swift
//  Feature
//
//  Created by HUNHEE LEE on 13.12.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import Foundation

struct Page: Identifiable, Equatable {
  let id = UUID()
  let pageNumber: Int
  let content: String
}
