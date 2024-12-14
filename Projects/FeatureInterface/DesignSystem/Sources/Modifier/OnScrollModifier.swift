//
//  OnScrollModifier.swift
//  DesignSystem
//
//  Created by HUNHEE LEE on 3.09.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import SwiftUI

public struct OnScrollModifier: ViewModifier {
  var action: () -> Void

  public func body(content: Content) -> some View {
    content
      .simultaneousGesture(
        DragGesture().onChanged { _ in
          action()
        }
      )
  }
}

public extension View {
  func onScroll(action: @escaping () -> Void) -> some View {
    modifier(OnScrollModifier(action: action))
  }
}
