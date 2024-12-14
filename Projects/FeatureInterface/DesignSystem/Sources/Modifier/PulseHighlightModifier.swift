//
//  PulseHighlightModifier.swift
//  DesignSystem
//
//  Created by HUNHEE LEE on 20.09.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import SwiftUI

struct PulseHighlightModifier: ViewModifier {
  @Binding var isHighlighted: Bool
  @State private var scale: CGFloat = 1.0

  func body(content: Content) -> some View {
    content
      .scaleEffect(scale)
      .onAppear {
        if isHighlighted {
          withAnimation {
            scale = 1.05
          }
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {
            withAnimation {
              scale = 1.0
            }
          }
        }
      }
  }
}

public extension View {
  func pulseHighlight(isHighlighted: Binding<Bool>) -> some View {
    modifier(PulseHighlightModifier(isHighlighted: isHighlighted))
  }
}
