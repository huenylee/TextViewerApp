//
//  FileRepositoryImpl.swift
//  Data
//
//  Created by HUNHEE LEE on 24.09.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import Foundation
import DomainInterface

public struct FileRepositoryImpl: FileRepository {
  private let fileManager = FileManager.default
  private static let baseDirectory: URL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: .userDomainMask)[0]
  
  public init() { }
  
  private func resolveURL(path: String) throws -> URL {
    let decodedPath = path.removingPercentEncoding ?? path
    let cleanPath = decodedPath
      .components(separatedBy: "/")
      .map { component in
        return component.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? component
      }
      .joined(separator: "/")

    if path.isEmpty {
      return Self.baseDirectory
    }

    return Self.baseDirectory.appendingPathComponent(path)
  }
  
  public func createDirectory(name: String, at path: String = "") throws {
    let baseURL = try resolveURL(path: path)
    let newDirectory = baseURL.appendingPathComponent(name)
    
    if fileManager.fileExists(atPath: newDirectory.path) {
      throw FileRepositoryError.directoryAlreadyExists
    }
    do {
      try fileManager.createDirectory(at: newDirectory, withIntermediateDirectories: true, attributes: nil)
    } catch {
      throw FileRepositoryError.createDirectoryFailed(error: error)
    }
  }
  
  public func saveFile(file: Data, at path: String) throws {
    let url = try resolveURL(path: path)
    
    if fileManager.fileExists(atPath: url.path) {
      throw FileRepositoryError.fileAlreadyExists
    }
    
    do {
      try file.write(to: url)
    } catch {
      throw FileRepositoryError.writeFailed(error: error)
    }
  }
  
  public func deleteFile(at path: String) throws {
    let url = try resolveURL(path: path)

    do {
      try fileManager.removeItem(at: url)
    } catch {
      throw FileRepositoryError.deleteFailed(error: error)
    }
  }
  
  public func renameFile(at path: String, newName: String) throws {
    let url = try resolveURL(path: path)
    let fileExtension = url.pathExtension
    let newURL = url.deletingLastPathComponent().appendingPathComponent(newName).appendingPathExtension(fileExtension)
    
    if fileManager.fileExists(atPath: newURL.path) {
      throw FileRepositoryError.fileAlreadyExists
    }
    
    do {
      try fileManager.moveItem(at: url, to: newURL)
    } catch {
      throw FileRepositoryError.renameFailed(error: error)
    }
  }
  
  public func listFiles(at path: String) throws -> [FileInfo] {
    let directoryURL = try resolveURL(path: path)
    
    do {
      let fileURLs = try fileManager.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: [.isDirectoryKey, .fileSizeKey, .creationDateKey, .contentModificationDateKey, .pathKey, .canonicalPathKey], options: .skipsHiddenFiles)
      
      return try fileURLs.map { url in
        let resourceValues = try url.resourceValues(forKeys: [.isDirectoryKey, .fileSizeKey, .creationDateKey, .contentModificationDateKey, .pathKey, .canonicalPathKey])
        
        var numberOfItems: Int? = nil
        if resourceValues.isDirectory ?? false {
          let subItems = try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
          numberOfItems = subItems.count
        }
        
        var fileData: Data?
        if let isDirectory = resourceValues.isDirectory,
           !isDirectory {
          fileData = try Data(contentsOf: url)
        }
        
        let relativePath = url.path.replacingOccurrences(of: Self.baseDirectory.path, with: "")
                                    .trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        
        return FileInfo(
          name: url.lastPathComponent,
          isDirectory: resourceValues.isDirectory ?? false,
          fileSize: resourceValues.fileSize.map { Int64($0) },
          creationDate: resourceValues.creationDate,
          modificationDate: resourceValues.contentModificationDate,
          fileExtension: url.pathExtension,
          numberOfItems: numberOfItems,
          data: fileData,
          path: relativePath
        )
      }
    } catch {
      throw FileRepositoryError.listFilesFailed(error: error)
    }
  }
}
