//
//  DownloadFileUseCase.swift
//  Domain
//
//  Created by HUNHEE LEE on 24.09.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import Foundation

public protocol DownloadFileUseCase {
  func execute(file: Data, fileName: String, at path: String) throws
}
