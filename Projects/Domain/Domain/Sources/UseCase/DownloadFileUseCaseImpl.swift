//
//  DownloadFileUseCaseImpl.swift
//  Domain
//
//  Created by HUNHEE LEE on 24.09.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import Foundation
import DomainInterface

public struct DownloadFileUseCaseImpl: DownloadFileUseCase {
  private let repository: FileRepository
  
  public func execute(file: Data, fileName: String, at path: String) throws {
    let fullyPath: String = path + "/" + fileName
    try repository.saveFile(file: file, at: fullyPath)
  }
  
  public init(repository: FileRepository) {
    self.repository = repository
  }
}
