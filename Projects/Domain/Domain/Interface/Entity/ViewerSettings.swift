//
//  ViewerSettings.swift
//  Domain
//
//  Created by HUNHEE LEE on 12.12.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

public struct ViewerSettings: Equatable {
  public let fontSize: Int
  public let lineHeight: Double
  
  public init(fontSize: Int, lineHeight: Double) {
    self.fontSize = fontSize
    self.lineHeight = lineHeight
  }
  
  public var lineSpacing: Double {
    lineHeight * Double(fontSize)
  }
}
