//
//  TextContentReaderSearchFeature.swift
//  Feature
//
//  Created by HUNHEE LEE on 12.09.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import Combine
import ComposableArchitecture
import Foundation

@Reducer
public struct TextContentReaderSearchFeature {
  public typealias SearchResult = ContentTextChunk

  @ObservableState
  public struct State: Equatable {
    var isVisible: Bool = false
    var searchQuery: String = ""
    var searchResults: [SearchResult] = []
    var allData: [ContentTextChunk]
  }

  public enum Action {
    case dismiss
    case setVisibility(Bool)
    case setSearchQuery(String)
    case performSearch
    case searchResults([SearchResult])
    case tappedResult(scrollId: Int)
  }

  public enum Destination: Hashable {
    case settings
  }

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .setSearchQuery(let query):
        state.searchQuery = query
        guard query.isEmpty else { return .none }
        return .send(.performSearch)
      case .searchResults(let results):
        state.searchResults = results
        return .none
      case .performSearch:
        let query = state.searchQuery
        let filtered = state.allData.filter { chunk in
          chunk.paragraph.contains(query)
        }
        return .send(.searchResults(filtered))
      case .setVisibility(let isVisible):
        state.isVisible = isVisible
        return .none
      case .dismiss:
        state.searchQuery = ""
        state.searchResults = []
        return .send(.setVisibility(false))
      case .tappedResult(let scrollId):
        return .send(.dismiss)
      }
    }
  }
}
