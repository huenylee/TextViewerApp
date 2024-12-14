//
//  SheetItemList.swift
//  DesignSystem
//
//  Created by HUNHEE LEE on 18.11.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import SwiftUI
import Shared

public struct SheetItemList: View {
  
  public struct Item: Identifiable {
    public let id = UUID()
    let imageName: String
    let title: String
    let action: () -> Void
    
    public init(
      imageName: String,
      title: String,
      action: @escaping () -> Void
    ) {
      self.imageName = imageName
      self.title = title
      self.action = action
    }
  }
  
  private let items: [Item]
  
  public init(items: [Item]) {
    self.items = items
  }
  
  public init(@ArrayBuilder<Item> items: () -> [Item]) {
    self.items = items()
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      ForEach(items) { item in
        ItemView(item: item)
      }
    }
  }
  
  // MARK: - Subviews
  private struct ItemView: View {
    let item: Item
    
    var body: some View {
      ZStack {
        AppColor.appWhite.swiftUIColor
        
        HStack(spacing: 0) {
          Image(systemName: item.imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 20)
            .padding(.leading, 30)
          
          Text(item.title)
            .padding(.leading, 26)
          
          Spacer()
        }
        .padding(.vertical, 17)
      }
      .frame(height: 64)
      .pressableWithTapGesture(action: item.action)
    }
  }
}
