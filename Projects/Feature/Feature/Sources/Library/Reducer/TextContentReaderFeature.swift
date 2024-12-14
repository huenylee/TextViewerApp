//
//  TextContentReaderFeature.swift
//  Feature
//
//  Created by HUNHEE LEE on 29.08.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import ComposableArchitecture
import DomainInterface

@Reducer
public struct TextContentReaderFeature {
  private let updateViewerSettingsUseCase: UpdateViewerSettingsUseCase
  
  public init(updateViewerSettingsUseCase: UpdateViewerSettingsUseCase) {
    self.updateViewerSettingsUseCase = updateViewerSettingsUseCase
  }
  
  @ObservableState
  public struct State: Equatable {
    var content: ContentItem
    var textItemList: [ContentTextChunk]
    var searchFeature: TextContentReaderSearchFeature.State
    var settingsFeature: TextContentReaderSettingsFeature.State

    var isOverlayVisible: Bool = false
    var highlightItem: Int?

    var viewerSettings: ViewerSettings
    var scrollViewPercentage: Double = 0
    var updateSource: UpdateSource = .none
    var scrolledId: Int

    public init(
      content: ContentItem,
      viewerSettings: ViewerSettings,
      scrolledId: Int,
      chunkSize: Int = 5
    ) {
      let textChunks = Self.createTextChunks(from: content.content, chunkSize: chunkSize)
      self.content = content
      self.textItemList = textChunks
      self.scrolledId = scrolledId
      self.searchFeature = TextContentReaderSearchFeature.State(allData: textChunks)
      self.settingsFeature = TextContentReaderSettingsFeature.State(settings: viewerSettings)
      self.viewerSettings = viewerSettings
    }

    static func createTextChunks(
      from content: String,
      chunkSize: Int
    ) -> [ContentTextChunk] {
      let lines = content.split(separator: "\n", omittingEmptySubsequences: false)
      var chunks: [ContentTextChunk] = []

      for (index, startIndex) in stride(from: 0, to: lines.count, by: chunkSize).enumerated() {
        let endIndex = min(startIndex + chunkSize, lines.count)
        var chunkLines = Array(lines[startIndex ..< endIndex])

        if endIndex == lines.count && chunkLines.count < chunkSize {
          let emptyLinesNeeded = 15 - chunkLines.count
          chunkLines.append(contentsOf: Array(repeating: Substring(""), count: emptyLinesNeeded))
        }

        let paragraph = chunkLines.joined(separator: "\n")
        chunks.append(ContentTextChunk(id: index, paragraph: paragraph))
      }

      return chunks
    }
  }

  public enum UpdateSource: Equatable {
    case none
    case scroll
    case slider
  }

  public enum Action: BindableAction {
    case toggleOverlay
    case searchFeature(TextContentReaderSearchFeature.Action)
    case settingFeature(TextContentReaderSettingsFeature.Action)

    case setOverlayVisibility(Bool)
    case setUpdateSource(UpdateSource)
    case setViewerSettings(ViewerSettings)
    case setScrollViewPercentage(Double)
    case setScrolledId(Int)

    case searchButtonTapped
    case textSettingsButtonTapped

    // 바인딩 액션 (TCA 요구 사항)
    case binding(BindingAction<State>)
  }

  public var body: some ReducerOf<TextContentReaderFeature> {
    Scope(state: \.searchFeature, action: \.searchFeature) {
      TextContentReaderSearchFeature()
    }
    Scope(state: \.settingsFeature, action: \.settingFeature) {
      TextContentReaderSettingsFeature(
        updateViewerSettingsUseCase: updateViewerSettingsUseCase
      )
    }
    Reduce { state, action in
      switch action {
      case .toggleOverlay:
        state.isOverlayVisible.toggle()
        return .none
      case .setOverlayVisibility(let isVisible):
        state.isOverlayVisible = isVisible
        return .none
      case .setScrollViewPercentage(let percentage):
        state.updateSource = .scroll
        state.scrollViewPercentage = percentage
        return .none
      case .searchButtonTapped:
        return .send(.searchFeature(.setVisibility(true)))
      case .textSettingsButtonTapped:
        return .send(.settingFeature(.setVisibility(true)))
      case .binding:
        return .none
      case .setUpdateSource(let updateSource):
        state.updateSource = updateSource
        return .none
      case .setScrolledId(let id):
        state.scrolledId = id
        return .none
      case .searchFeature(.tappedResult(let id)):
        state.isOverlayVisible = false
        state.scrolledId = id
        state.highlightItem = id

        return .none
      case .searchFeature:
        return .none
      case .settingFeature(.saveSettings):
        let newSettings = ViewerSettings(
          fontSize: state.settingsFeature.fontSize,
          lineHeight: state.settingsFeature.lineHeight
        )
        state.viewerSettings = newSettings
        return .none
      case .settingFeature(_):
        return .none
      case .setViewerSettings(let viewerSettings):
        state.viewerSettings = viewerSettings
        return .none
      }
    }
  }
}

public struct ContentTextChunk: Hashable {
  let id: Int
  let paragraph: String

  public static func == (lhs: ContentTextChunk, rhs: ContentTextChunk) -> Bool {
    return lhs.id == rhs.id
  }
}
