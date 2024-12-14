//
//  FetchFileListUseCaseImpl.swift
//  Domain
//
//  Created by HUNHEE LEE on 24.09.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import DomainInterface
import Foundation
import GlobalThirdPartyLibrary

public struct FetchFileListUseCaseImpl: FetchFileListUseCase {
  private let repository: FileRepository
  
  public func execute(at path: String) throws -> [LibraryItemWrapper] {
    let files = try repository
      .listFiles(at: path)
      .compactMap { $0.todomain() }
      .map { LibraryItemWrapper($0) }
    return files
  }
  
  public init(repository: FileRepository) {
    self.repository = repository
  }
}
