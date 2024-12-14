// This is for the feature

import SwiftUI

public typealias AppColor = DesignSystemAsset.Color

public extension AppColor {
  static func hex(hex: Int, opacity: Double = 1.0) -> Color {
    let red = Double((hex >> 16) & 0xff) / 255
    let green = Double((hex >> 8) & 0xff) / 255
    let blue = Double((hex >> 0) & 0xff) / 255

    return Color(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
  }
}
