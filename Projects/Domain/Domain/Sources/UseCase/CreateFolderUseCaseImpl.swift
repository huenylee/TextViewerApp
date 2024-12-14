//
//  CreateFolderUseCaseImpl.swift
//  Domain
//
//  Created by HUNHEE LEE on 14.11.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import Foundation
import DomainInterface

public struct CreateFolderUseCaseImpl: CreateFolderUseCase {
  private let repository: FileRepository
  
  public func execute(folderName: String, at path: String) throws {
    try repository.createDirectory(name: folderName, at: path)
  }
  
  public init(repository: FileRepository) {
    self.repository = repository
  }
}
