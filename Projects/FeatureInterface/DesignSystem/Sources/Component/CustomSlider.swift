//
//  CustomSlider.swift
//  DesignSystem
//
//  Created by HUNHEE LEE on 4.09.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import SwiftUI

public struct CustomSlider: View {
  @Binding var value: Double
  let range: ClosedRange<Double>
  var thumbSize: CGFloat = 18
  let showSteps: Bool
  let roundToNearestInt: Bool
  
  public init(
    value: Binding<Double>,
    range: ClosedRange<Double>,
    thumbSize: CGFloat = 22,
    showSteps: Bool = false,
    roundToNearestInt: Bool = false
  ) {
    self._value = value
    self.range = range
    self.thumbSize = thumbSize
    self.showSteps = showSteps
    self.roundToNearestInt = roundToNearestInt
  }
  
  @State private var percentage: CGFloat = 0
  
  private var rangeSize: Double { range.upperBound - range.lowerBound }
  
  public var body: some View {
    GeometryReader { geometry in
      sliderBody(in: geometry)
    }
    .frame(height: max(thumbSize, 35))
    .onAppear {
      percentage = calculatePercentage(from: value)
    }
    .onChange(of: value) { _, newValue in
      percentage = calculatePercentage(from: newValue)
    }
  }
  
  private func sliderBody(in geometry: GeometryProxy) -> some View {
    ZStack(alignment: .leading) {
      sliderTrack()
      sliderFill(width: percentage * geometry.size.width)
      sliderThumb(in: geometry)
    }
  }
  
  private func sliderTrack() -> some View {
    Rectangle()
      .fill(AppColor.appGray200.swiftUIColor)
      .clipShape(Capsule())
      .frame(height: 4)
  }
  
  //  private func sliderSteps(in geometry: GeometryProxy) -> some View {
  //    let stepWidth = geometry.size.width / CGFloat(rangeSize)
  //
  //    return ZStack {
  //      ForEach(2..<range.upperBound, id: \.self) { step in
  //            Rectangle()
  //                .fill(AppColor.appGray400.swiftUIColor)
  //                .frame(width: 1, height: 8)
  //                .offset(x: CGFloat(step - range.lowerBound) * stepWidth)
  //        }
  //    }
  //  }
  
  private func sliderFill(width: CGFloat) -> some View {
    Rectangle()
      .fill(AppColor.appPrimary.swiftUIColor)
      .clipShape(Capsule())
      .frame(width: width, height: 4)
  }
  
  private func sliderThumb(in geometry: GeometryProxy) -> some View {
    Circle()
      .fill(AppColor.appWhite.swiftUIColor)
      .shadow(radius: 1)
      .frame(width: thumbSize, height: thumbSize)
      .offset(x: percentage * (geometry.size.width - thumbSize))
      .gesture(
        DragGesture()
          .onChanged {
            updatePercentage(from: $0, in: geometry)
            
            if !roundToNearestInt {
              updateValue()
              percentage = calculatePercentage(from: value)
            }
          }
          .onEnded { _ in
            updateValue()
            percentage = calculatePercentage(from: value)
          }
      )
  }
  
  private func updatePercentage(from gesture: DragGesture.Value, in geometry: GeometryProxy) {
    percentage = min(max(gesture.location.x / geometry.size.width, 0), 1)
  }
  
  private func updateValue() {
    value = calculateValue(from: percentage)
  }
  
  private func calculateValue(from percentage: CGFloat) -> Double {
    let rawValue = Double(range.lowerBound) + Double(rangeSize) * Double(percentage)
    if roundToNearestInt {
      return Double(round(rawValue)).clamped(to: range)
    } else {
      return Double(rawValue).clamped(to: range)
    }
  }
  
  private func calculatePercentage(from value: Double) -> CGFloat {
    CGFloat(Double(value - range.lowerBound) / Double(rangeSize))
  }
}

extension Comparable {
  func clamped(to limits: ClosedRange<Self>) -> Self {
    min(max(self, limits.lowerBound), limits.upperBound)
  }
}
