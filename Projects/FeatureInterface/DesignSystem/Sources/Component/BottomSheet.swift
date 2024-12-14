//
//  BottomSheet.swift
//  DesignSystem
//
//  Created by HUNHEE LEE on 17.11.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import SwiftUI

public struct BottomSheet<Content: View>: View {
  let content: Content
  
  public init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }
  
  public var body: some View {
    VStack() {
      HStack(alignment: .center) {
        GrabberIndicator()
      }
      .padding(.top, 10)
      .padding(.bottom, 5)
      
      Spacer()
      
      content
      
      Spacer()
    }
  }
}
