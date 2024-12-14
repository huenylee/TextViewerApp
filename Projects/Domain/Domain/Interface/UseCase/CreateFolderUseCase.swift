//
//  CreateFolderUseCase.swift
//  Domain
//
//  Created by HUNHEE LEE on 14.11.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import Foundation

public protocol CreateFolderUseCase {
  func execute(folderName: String, at path: String) throws
}
