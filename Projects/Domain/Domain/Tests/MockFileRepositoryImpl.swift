//
//  MockFileRepositoryImpl.swift
//  Data
//
//  Created by HUNHEE LEE on 24.09.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import Foundation
import DomainInterface

class MockFileRepositoryImpl: FileRepository {
  private(set) var files: [String: Data] = [:]
  private(set) var directories: Set<String> = []

  func createDirectory(name: String, at path: String) throws {
    let fullPath = path.isEmpty ? name : "\(path)/\(name)"
    if directories.contains(fullPath) {
      throw FileRepositoryError.directoryAlreadyExists
    }
    directories.insert(fullPath)
  }

  func saveFile(file: Data, at fileName: String) throws {
    if files[fileName] != nil {
      throw FileRepositoryError.fileAlreadyExists
    }
    files[fileName] = file
  }

  func deleteFile(at path: String) throws {
    if files.removeValue(forKey: path) == nil {
      throw FileRepositoryError.fileDoesNotExist(fileName: path)
    }
  }

  func renameFile(at path: String, newName: String) throws {
    guard let file = files.removeValue(forKey: path) else {
      throw FileRepositoryError.fileDoesNotExist(fileName: path)
    }

    let newPath = (path as NSString).deletingLastPathComponent
    let newFullPath = (newPath as NSString).appendingPathComponent(newName)

    if files[newFullPath] != nil {
      throw FileRepositoryError.fileAlreadyExists
    }

    files[newFullPath] = file
  }

  func listFiles(at path: String) throws -> [FileInfo] {
    let relevantFiles = files.filter { $0.key.hasPrefix(path) }
    let relevantDirectories = directories.filter { $0.hasPrefix(path) }

    var fileInfos: [FileInfo] = []

    for (filePath, fileData) in relevantFiles {
      let url = URL(fileURLWithPath: filePath)
      fileInfos.append(
        FileInfo(
          name: url.lastPathComponent,
          isDirectory: false,
          fileSize: Int64(fileData.count),
          creationDate: Date(),
          modificationDate: Date(),
          fileExtension: url.pathExtension,
          numberOfItems: nil,
          data: fileData,
          path: filePath
        ))
    }

    for directoryPath in relevantDirectories {
      let url = URL(fileURLWithPath: directoryPath)
      fileInfos.append(
        FileInfo(
          name: url.lastPathComponent,
          isDirectory: true,
          fileSize: nil,
          creationDate: Date(),
          modificationDate: Date(),
          fileExtension: "",
          numberOfItems: 0,
          data: nil,
          path: directoryPath
        ))
    }

    return fileInfos
  }

  // 테스트를 위한 헬퍼 메서드들
  func reset() {
    files.removeAll()
    directories.removeAll()
  }

  // 테스트에서 내부 상태를 확인하기 위한 메서드들
  func fileExists(at path: String) -> Bool {
    files[path] != nil
  }

  func directoryExists(at path: String) -> Bool {
    directories.contains(path)
  }
}
