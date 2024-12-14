//
//  TouchDetectionGesture.swift
//  DesignSystem
//
//  Created by HUNHEE LEE on 19.09.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import SwiftUI

enum TouchUpType {
  case inside
  case outside
}

struct TouchDetectionGesture: UIViewRepresentable {
  let onTouchDown: () -> Void
  let onTouchUp: (TouchUpType) -> Void
  let onTap: () -> Void

  func makeUIView(context: Context) -> UIView {
    let view = UIView()
    view.isUserInteractionEnabled = true

    let tapGesture = UITapGestureRecognizer(
      target: context.coordinator,
      action: #selector(Coordinator.handleTap(_:))
    )
    tapGesture.delegate = context.coordinator
    view.addGestureRecognizer(tapGesture)

    let touchDownGesture = TouchDownGestureRecognizer(
      target: context.coordinator,
      action: #selector(Coordinator.handleTouchDown(_:))
    )
    touchDownGesture.delegate = context.coordinator
    view.addGestureRecognizer(touchDownGesture)

    return view
  }

  func updateUIView(_ uiView: UIView, context: Context) {}

  func makeCoordinator() -> Coordinator {
    Coordinator(
      onTouchDown: onTouchDown,
      onTouchUp: onTouchUp,
      onTap: onTap
    )
  }

  class Coordinator: NSObject, UIGestureRecognizerDelegate {
    let onTouchDown: () -> Void
    let onTouchUp: (TouchUpType) -> Void
    let onTap: () -> Void

    init(
      onTouchDown: @escaping () -> Void,
      onTouchUp: @escaping (TouchUpType) -> Void,
      onTap: @escaping () -> Void
    ) {
      self.onTouchDown = onTouchDown
      self.onTouchUp = onTouchUp
      self.onTap = onTap
    }

    @objc func handleTouchDown(_ gesture: UIGestureRecognizer) {
      if gesture.state == .began {
        onTouchDown()
      } else if gesture.state == .ended {
        onTouchUp(.inside)
      } else  {
        onTouchUp(.outside)
      }
    }

    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
      if gesture.state == .ended {
        onTap()
      }
    }

    func gestureRecognizer(
      _ gestureRecognizer: UIGestureRecognizer,
      shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
      return true
    }
  }
}

class TouchDownGestureRecognizer: UIGestureRecognizer {
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
    state = .began
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
    guard let touch = touches.first, let view = view else { return }

    let location = touch.location(in: view)
    if view.bounds.contains(location) {
      state = .ended
    } else {
      state = .cancelled
    }
  }

  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
    state = .cancelled
  }
}
