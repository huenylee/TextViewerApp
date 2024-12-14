//
//  ContentReaderSearch.swift
//  Feature
//
//  Created by HUNHEE LEE on 10.09.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import Combine
import ComposableArchitecture
import DesignSystem
import SwiftUI

public struct ContentReaderSearch: View {
  @FocusState private var isSearchFieldFocused: Bool
  @Bindable var store: StoreOf<TextContentReaderSearchFeature>

  private let querySubject = PassthroughSubject<String, Never>()
  @State private var cancellables = Set<AnyCancellable>()

  public var body: some View {
    Group {
      searchBar()
      searchResultsList()
    }
    .onAppear {
      self.isSearchFieldFocused = true
    }
  }

  private func setupSearchDebounce() {
    querySubject
      .debounce(for: .seconds(0.65), scheduler: DispatchQueue.main)
      .sink { [weak store] _ in
        store?.send(.performSearch)
      }
      .store(in: &cancellables)
  }

  @ViewBuilder
  func searchBar() -> some View {
    VStack(spacing: 0) {
      HStack(spacing: 0) {
        ZStack {
          Rectangle()
            .fill(AppColor.appGray100.swiftUIColor)
            .clipShape(.rect(cornerRadius: 10))
          
          HStack(spacing: 0) {
            Image(systemName: "magnifyingglass")
              .font(.system(size: 16))
              .foregroundStyle(AppColor.appGray500.swiftUIColor)
              .padding(.leading, 2)
            
            TextField(
              "검색",
              text: Binding(
                get: { store.state.searchQuery },
                set: { newValue, _ in store.send(.setSearchQuery(newValue)) }
              )
            )
            .padding(.leading, 6)
            .font(AppFont.pretendard(.regular).of(size: 16))
            .focused($isSearchFieldFocused)
            .submitLabel(.search)
            .onSubmit {
              store.send(.performSearch)
            }
            
            Spacer()
            
            if !store.state.searchQuery.isEmpty {
              Button {
                store.send(.setSearchQuery(""))
              } label: {
                Image(systemName: "xmark.circle.fill")
                  .font(.system(size: 16))
                  .foregroundStyle(AppColor.appGray500.swiftUIColor)
              }
            }
          }
          .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
        }
        .frame(height: 44)
        .padding(.trailing, 14)
        
        Button {
          store.send(.dismiss)
        } label: {
          Text("닫기")
            .font(AppFont.pretendard(.regular).of(size: 16))
            .foregroundStyle(AppColor.appGray700.swiftUIColor)
        }
      }
      .padding(.top, 18)
      .padding(.bottom, 10)
      .padding(.horizontal, 20)
      
      Spacer()
      
      Divider()
    }
    .frame(maxHeight: 65)
  }

  @ViewBuilder
  func searchResultsList() -> some View {
    List {
      ForEach(store.searchResults, id: \.id) { item in
        VStack(spacing: 0) {
          Spacer()
          
          HStack {
            let result = item.paragraph.withoutLineBreaks()
            
            HighlightText(
              text: result,
              textColor: AppColor.appGray600.swiftUIColor,
              font: AppFont.pretendard(.regular).of(size: 16),
              highlightString: store.state.searchQuery,
              highlightColor: AppColor.appBlack.swiftUIColor,
              highlightFont: AppFont.pretendard(.semiBold).of(size: 16)
            )
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
            
            Spacer()
          }
          
          Spacer()
          
          Divider()
        }
        .frame(height: 95)
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
        .pressableWithTapGesture {
          store.send(.tappedResult(scrollId: item.id))
        }
      }
    }
    .listStyle(.plain)
    .onScroll {
      self.isSearchFieldFocused = false
    }
  }
}
