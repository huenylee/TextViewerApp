//
//  HighlightText.swift
//  DesignSystem
//
//  Created by HUNHEE LEE on 19.09.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import Foundation
import SwiftUI

public struct HighlightText: View {
  let text: String
  let textColor: Color
  let font: Font
  let highlightString: String
  let highlightColor: Color
  var highlightFont: Font?

  public init(
    text: String,
    textColor: Color,
    font: Font,
    highlightString: String,
    highlightColor: Color,
    highlightFont: Font? = nil
  ) {
    self.text = text
    self.textColor = textColor
    self.font = font
    self.highlightString = highlightString
    self.highlightColor = highlightColor
    self.highlightFont = highlightFont ?? font
  }

  public var body: some View {
    highlightingText()
  }

  func highlightingText() -> Text {
    guard !highlightString.isEmpty else {
      return unmatchText(text)
    }

    var resultText = Text("")
    var headIndex: String.Index = text.startIndex

    for range in text.ranges(of: highlightString) {
      let unmatchString = String(text[headIndex..<range.lowerBound])
      let matchString = String(text[range.lowerBound..<range.upperBound])

      headIndex = range.upperBound
      resultText = resultText + unmatchText(unmatchString) + matchText(matchString)
    }

    if headIndex < text.endIndex {
      let unmatchString = String(text[headIndex..<text.endIndex])
      resultText = resultText + unmatchText(unmatchString)
    }

    return resultText
  }

  private func unmatchText(_ string: String) -> Text {
    Text(string)
      .font(font)
      .foregroundColor(textColor)
  }

  private func matchText(_ string: String) -> Text {
    Text(string)
      .font(highlightFont)
      .foregroundColor(highlightColor)
  }
}
