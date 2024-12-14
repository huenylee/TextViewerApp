//
//  String+Extension.swift
//  Shared
//
//  Created by HUNHEE LEE on 19.09.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import Foundation

public extension String {
  /// 문자열에서 연속된 개행을 공백 하나로 치환하는 함수
  /// - Returns: 개행 대신 공백 1개가 포함된 문자열
  func withoutLineBreaks() -> String {
    return self.replacingOccurrences(of: "\\s*\n\\s*", with: " ", options: .regularExpression)
  }

  /// 연속되는 개행 문자를 하나의 개행 문자로 치환하는 함수
  /// - Returns: 연속된 개행이 하나로 치환된 문자열
  func singleLineBreaks() -> String {
    return self.replacingOccurrences(of: "\n+", with: "\n", options: .regularExpression)
  }
}
