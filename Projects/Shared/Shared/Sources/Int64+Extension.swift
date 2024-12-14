//
//  Int64+Extension.swift
//  Shared
//
//  Created by HUNHEE LEE on 12.12.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import Foundation

public extension Int64 {
  enum FileSizeUnit: String {
    case byte = "B"
    case kilobyte = "KB"
    case megabyte = "MB"
    case gigabyte = "GB"
    case terabyte = "TB"
    
    var byteSize: Int64 {
      switch self {
      case .byte:      return 1
      case .kilobyte:  return 1024
      case .megabyte:  return 1024 * 1024
      case .gigabyte:  return 1024 * 1024 * 1024
      case .terabyte:  return 1024 * 1024 * 1024 * 1024
      }
    }
  }
  
  /// 파일 크기를 자동으로 적절한 단위로 변환
  func toFileSize(decimals: Int = 2) -> String {
    let units: [FileSizeUnit] = [.byte, .kilobyte, .megabyte, .gigabyte, .terabyte]
    
    var size = Double(self)
    var unit = units[0]
    
    for nextUnit in units[1...] {
      if size < 1024 { break }
      size /= 1024
      unit = nextUnit
    }
    
    // 소수점 형식 지정
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = size.truncatingRemainder(dividingBy: 1) == 0 ? 0 : decimals
    formatter.maximumFractionDigits = decimals
    
    guard let formattedSize = formatter.string(from: NSNumber(value: size)) else {
      return "\(size)\(unit.rawValue)"
    }
    
    return "\(formattedSize) \(unit.rawValue)"
  }
  
  /// 특정 단위로 변환
  func toFileSize(unit: FileSizeUnit, decimals: Int = 2) -> String {
    let size = Double(self) / Double(unit.byteSize)
    
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = size.truncatingRemainder(dividingBy: 1) == 0 ? 0 : decimals
    formatter.maximumFractionDigits = decimals
    
    guard let formattedSize = formatter.string(from: NSNumber(value: size)) else {
      return "\(size)\(unit.rawValue)"
    }
    
    return "\(formattedSize) \(unit.rawValue)"
  }
}
