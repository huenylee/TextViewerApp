//
//  PressableModifier.swift
//  DesignSystem
//
//  Created by HUNHEE LEE on 3.09.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import SwiftUI

public extension View {
  func pressableWithTapGesture(action: @escaping () -> Void) -> some View {
    modifier(PressableModifier(action: action))
  }
}

public struct PressableModifier: ViewModifier {
  @State private var isPressed = false
  var action: () -> Void

  public func body(content: Content) -> some View {
    content
      .overlay(
        Color.black.opacity(isPressed ? 0.05 : 0)
      )
      .overlay(
        TouchDetectionGesture(
          onTouchDown: {
            withAnimation(.easeIn(duration: 0.08)) {
              self.isPressed = true
            }
          },
          onTouchUp: { _ in
            withAnimation(.easeOut(duration: 0.08)) {
              self.isPressed = false
            }
          },
          onTap: {
            self.action()
          }
        )
      )
  }
}
