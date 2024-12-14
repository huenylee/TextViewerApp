//
//  DocumentPicker.swift
//  Feature
//
//  Created by HUNHEE LEE on 30.08.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import SwiftUI
import UniformTypeIdentifiers

struct DocumentPicker: UIViewControllerRepresentable {
  @Binding var fileURL: URL?
  let contentTypes: [UTType]
  let onPick: (URL) -> Void

  func makeUIViewController(context: Context) -> some UIViewController {
    let picker = UIDocumentPickerViewController(forOpeningContentTypes: contentTypes, asCopy: true)
    picker.delegate = context.coordinator
    return picker
  }

  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  class Coordinator: NSObject, UIDocumentPickerDelegate {
    let parent: DocumentPicker

    init(_ parent: DocumentPicker) {
      self.parent = parent
    }

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
      guard let url = urls.first else { return }
      parent.fileURL = url
      parent.onPick(url)
    }
  }
}
