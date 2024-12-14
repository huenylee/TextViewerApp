//
//  MockLoadFileListUseCase.swift
//  Domain
//
//  Created by HUNHEE LEE on 27.08.2024.
//  Copyright © 2024 com.hunhee. All rights reserved.
//

import DomainInterface
import Foundation
import GlobalThirdPartyLibrary

public struct MockLoadFileListUseCaseImpl: FetchFileListUseCase {
  public var executeResult: Result<[LibraryItemWrapper], Error>

  public init(
    executeResult: Result<[LibraryItemWrapper], Error> = .success(
      [
        LibraryItemWrapper(
          ContentItem(
            name: "테스트를 위한 콘텐츠 파일1ㅁㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇ",
            createdDate: Date(),
            fileSize: 1300,
            type: .content(.txt),
            content: """
              잃어버린 시간의 조각

              김철수는 창밖으로 흩날리는 벚꽃 잎을 바라보며 한숨을 쉬었다. 봄이 왔다는 건 또 다시 시간이 흘러갔다는 뜻이었다.

              "벌써 일 년이 지났구나..."

              그는 책상 서랍을 열어 오래된 사진 한 장을 꺼내들었다. 사진 속에서 환하게 웃고 있는 여자를 보며 그는 쓴웃음을 지었다.

              "미영아, 잘 지내고 있니?"

              갑자기 전화벨이 울렸다. 철수는 흠칫 놀라 사진을 떨어뜨렸다.

              "여보세요?"

              "철수야, 나 준호야. 잘 지내고 있어?"

              "아, 준호야. 그래, 잘 지내고 있어. 근데 무슨 일이야?"

              잠시 침묵이 흘렀다. 철수는 불안한 예감을 지울 수 없었다.

              "저기... 미영이가 돌아왔어."

              철수의 손에서 전화기가 미끄러져 내렸다. 귓가에 준호의 목소리가 희미하게 들려왔다.

              "철수야? 철수야, 들리니?"

              그는 천천히 전화기를 주워들었다.

              "미영이가... 어디로 돌아왔다는 거야?"

              "서울로 돌아왔어. 어제 저녁에 봤어."

              철수는 입술을 깨물었다. 마음 속에서 분노와 그리움이 뒤엉켰다.

              "그래서 뭐라고 하던?"

              "너를 찾더라."

              철수는 깊은 한숨을 내쉬었다. 창밖으로 벚꽃이 더욱 거세게 흩날렸다.

              "고마워, 준호야. 나중에 다시 연락할게."

              전화를 끊은 철수는 한동안 그 자리에 멍하니 서 있었다. 시간이 얼마나 흘렀을까, 그는 천천히 외투를 걸치고 현관으로 향했다.

              문을 열자 차가운 봄바람이 얼굴을 스쳤다. 철수는 주머니에서 사진을 꺼내 한 번 더 바라보았다.

              "미영아... 이제 어떡하지?"

              그는 깊은 숨을 내쉬고 첫 걸음을 내딛었다. 봄바람에 벚꽃 잎이 흩날리는 거리로...

              (계속...)
              """,
            path: "test"
          )
        ),
        LibraryItemWrapper(
          FolderItem(
            name: "테스트 폴더",
            createdDate: Date(),
            subfilesCount: 3,
            path: "test"
          )
        ),
      ]
    )
  ) {
    self.executeResult = executeResult
  }

  public func execute(at path: String) throws -> [LibraryItemWrapper] {
    switch executeResult {
    case .success(let items):
      return items
    case .failure(let error):
      throw error
    }
  }
}
