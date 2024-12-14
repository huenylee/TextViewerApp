//
//  GrabberIndicator.swift
//  DesignSystem
//
//  Created by HUNHEE LEE on 17.11.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import SwiftUI

public struct GrabberIndicator: View {
  public init() { }
  
  public var body: some View {
    Capsule()
      .frame(width: 40, height: 4)
      .foregroundColor(AppColor.appGray400.swiftUIColor)
  }
}
