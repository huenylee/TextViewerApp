// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  import UIKit.UIFont
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
public enum DesignSystemFontFamily: Sendable {
  public enum Pretendard: Sendable {
    public static let black = DesignSystemFontConvertible(name: "Pretendard-Black", family: "Pretendard", path: "Pretendard-Black.ttf")
    public static let bold = DesignSystemFontConvertible(name: "Pretendard-Bold", family: "Pretendard", path: "Pretendard-Bold.ttf")
    public static let extraBold = DesignSystemFontConvertible(name: "Pretendard-ExtraBold", family: "Pretendard", path: "Pretendard-ExtraBold.ttf")
    public static let extraLight = DesignSystemFontConvertible(name: "Pretendard-ExtraLight", family: "Pretendard", path: "Pretendard-ExtraLight.ttf")
    public static let light = DesignSystemFontConvertible(name: "Pretendard-Light", family: "Pretendard", path: "Pretendard-Light.ttf")
    public static let medium = DesignSystemFontConvertible(name: "Pretendard-Medium", family: "Pretendard", path: "Pretendard-Medium.ttf")
    public static let regular = DesignSystemFontConvertible(name: "Pretendard-Regular", family: "Pretendard", path: "Pretendard-Regular.ttf")
    public static let semiBold = DesignSystemFontConvertible(name: "Pretendard-SemiBold", family: "Pretendard", path: "Pretendard-SemiBold.ttf")
    public static let thin = DesignSystemFontConvertible(name: "Pretendard-Thin", family: "Pretendard", path: "Pretendard-Thin.ttf")
    public static let all: [DesignSystemFontConvertible] = [black, bold, extraBold, extraLight, light, medium, regular, semiBold, thin]
  }
  public enum RIDIBatang: Sendable {
    public static let regular = DesignSystemFontConvertible(name: "RIDIBatang", family: "RIDIBatang", path: "RIDIBatang.otf")
    public static let all: [DesignSystemFontConvertible] = [regular]
  }
  public static let allCustomFonts: [DesignSystemFontConvertible] = [Pretendard.all, RIDIBatang.all].flatMap { $0 }
  public static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

public struct DesignSystemFontConvertible: Sendable {
  public let name: String
  public let family: String
  public let path: String

  #if os(macOS)
  public typealias Font = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Font = UIFont
  #endif

  public func font(size: CGFloat) -> Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    return font
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public func swiftUIFont(size: CGFloat) -> SwiftUI.Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    #if os(macOS)
    return SwiftUI.Font.custom(font.fontName, size: font.pointSize)
    #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
    return SwiftUI.Font(font)
    #endif
  }
  #endif

  public func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    // swiftlint:disable:next implicit_return
    return Bundle.module.url(forResource: path, withExtension: nil)
  }
}

public extension DesignSystemFontConvertible.Font {
  convenience init?(font: DesignSystemFontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(macOS)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
  }
}
// swiftlint:enable all
// swiftformat:enable all
