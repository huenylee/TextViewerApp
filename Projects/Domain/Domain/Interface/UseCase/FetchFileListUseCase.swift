//
//  FetchFileListUseCase.swift
//  Domain
//
//  Created by HUNHEE LEE on 27.08.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import Foundation

public protocol FetchFileListUseCase {
  func execute(at path: String) throws -> [LibraryItemWrapper]
}
