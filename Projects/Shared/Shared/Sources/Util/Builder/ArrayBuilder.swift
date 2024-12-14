//
//  ArrayBuilder.swift
//  Shared
//
//  Created by HUNHEE LEE on 18.11.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

@resultBuilder
public struct ArrayBuilder<T> {
  public static func buildBlock(_ components: T...) -> [T] {
    components
  }
}
