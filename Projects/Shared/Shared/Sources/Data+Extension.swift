//
//  Data+Extension.swift
//  Shared
//
//  Created by HUNHEE LEE on 2.10.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import Foundation

public extension Data {
  func checkFileType() -> FileType {
    if String(data: self, encoding: .utf8) != nil {
      return .txt
    }
    
    let pdfMagicNumber = Data([0x25, 0x50, 0x44, 0x46, 0x2D])
    
    if self.prefix(pdfMagicNumber.count) == pdfMagicNumber {
      return .pdf
    }
    
    return .unknown
  }

  enum FileType {
    case pdf
    case txt
    case unknown
  }
}
