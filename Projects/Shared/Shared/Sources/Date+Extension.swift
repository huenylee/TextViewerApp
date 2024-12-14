//
//  Date+Extension.swift
//  Shared
//
//  Created by HUNHEE LEE on 12.12.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import Foundation

public extension Date {
  enum DateFormat {
    case dotted          // YYYY.MM.dd
    case slashed         // YYYY/MM/dd
    case dashed         // YYYY-MM-dd
    case koreanStyle    // YYYY년 MM월 dd일
    case compact        // YYYYMMdd
    case custom(String) // 커스텀 포맷
    
    var formatString: String {
      switch self {
      case .dotted:
        return "yyyy.MM.dd"
      case .slashed:
        return "yyyy/MM/dd"
      case .dashed:
        return "yyyy-MM-dd"
      case .koreanStyle:
        return "yyyy년 MM월 dd일"
      case .compact:
        return "yyyyMMdd"
      case .custom(let format):
        return format
      }
    }
  }
  
  // 기본 날짜 포맷팅
  func formatted(_ format: DateFormat = .dotted, locale: Locale = Locale(identifier: "ko_KR")) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format.formatString
    formatter.locale = locale
    return formatter.string(from: self)
  }
  
  // 시간 포함 포맷팅
  func formattedWithTime(_ format: DateFormat = .dotted, timeStyle: TimeStyle = .short, locale: Locale = Locale(identifier: "ko_KR")) -> String {
    let dateString = formatted(format, locale: locale)
    
    let timeFormatter = DateFormatter()
    timeFormatter.locale = locale
    
    switch timeStyle {
    case .none:
      return dateString
    case .short:
      timeFormatter.timeStyle = .short
    case .medium:
      timeFormatter.timeStyle = .medium
    case .full:
      timeFormatter.timeStyle = .full
    }
    
    timeFormatter.dateFormat = "HH:mm"
    let timeString = timeFormatter.string(from: self)
    
    return "\(dateString) \(timeString)"
  }
  
  enum TimeStyle {
    case none   // 시간 표시 안 함
    case short  // HH:mm
    case medium // HH:mm:ss
    case full   // HH:mm:ss.SSS
  }
  
  // 상대적 시간 표시
  var relativeTime: String {
    let formatter = RelativeDateTimeFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.unitsStyle = .full
    return formatter.localizedString(for: self, relativeTo: Date())
  }
  
  // 특정 컴포넌트만 추출
  func component(_ component: Calendar.Component) -> Int {
    return Calendar.current.component(component, from: self)
  }
  
  // 날짜 비교 유틸리티
  var isToday: Bool {
    return Calendar.current.isDateInToday(self)
  }
  
  var isYesterday: Bool {
    return Calendar.current.isDateInYesterday(self)
  }
  
  var isTomorrow: Bool {
    return Calendar.current.isDateInTomorrow(self)
  }
}
