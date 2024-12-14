//
//  InfoPlist.swift
//  Manifests
//
//  Created by HUNHEE LEE on 14.11.2024.
//

import ProjectDescription

public extension InfoPlist {
  static func base(configuration: Configuration) -> InfoPlist {
    return .extendingDefault(with: [
      "CFBundleDisplayName": .string("$(APP_DISPLAY_NAME)"),
      "CFBundleShortVersionString": .string("1.0.0"), // 또는 환경변수로 관리
      "CFBundleVersion": .string("1"),
      
      // 필수 설정
      "UILaunchStoryboardName": .string("LaunchScreen"),
      "UIApplicationSceneManifest": [
        "UIApplicationSupportsMultipleScenes": false,
        "UISceneConfigurations": [
          "UIWindowSceneSessionRoleApplication": [
            [
              "UISceneConfigurationName": "Default Configuration",
              "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
            ]
          ]
        ]
      ],
      
      // 지원하는 방향
      "UISupportedInterfaceOrientations": .array([
        "UIInterfaceOrientationPortrait"
      ]),
      
      // Files 앱 통합
      "UIFileSharingEnabled": true,
      "LSSupportsOpeningDocumentsInPlace": true,
      
      // Documents 타입 정의
      "CFBundleDocumentTypes": .array([
        [
          "CFBundleTypeName": "Text Document",
          "LSHandlerRank": "Default",
          "LSItemContentTypes": .array([
            "public.text",
            "public.plain-text",
            "public.utf8-plain-text",
            "public.utf16-external-plain-text",
            "public.utf16-plain-text",
            "com.apple.traditional-mac-plain-text"
          ])
        ]
      ]),
      
      // 로컬라이제이션
      "CFBundleAllowMixedLocalizations": true,
      "CFBundleDevelopmentRegion": "ko",
      
      // 필요한 권한 설명
      "NSDocumentsFolderUsageDescription": .string("Document access is required to read and save text files."),
      
      // 환경별 설정
      "APP_ENV": .string(configuration.name.rawValue)
    ])
  }
}
