import Domain
import DomainInterface
import Testing

@Suite("DownloadFileUseCaseTests")
struct DownloadFileUseCaseTests {
  // SetUp
  let mockRepository = MockFileRepositoryImpl()
  let testData = "Hello, World!".data(using: .utf8)!
  let fileName = "test.txt"
  let path = "/documents/"
  
  @Test("파일 다운로드 성공")
  func testSuccessfulFileDownload() throws {
    // Given
    let useCase = DownloadFileUseCaseImpl(repository: mockRepository)
    try useCase.execute(file: testData, fileName: fileName, at: path)

    let fullPath = path + fileName
    #expect(mockRepository.fileExists(at: fullPath))
    #expect(mockRepository.files[fullPath] == testData)
  }

  @Test("이미 존재하는 파일명으로 다운로드 시도")
  func testDownloadWithExistingFileName() throws {
    // Given
    let useCase = DownloadFileUseCaseImpl(repository: mockRepository)
    try? mockRepository.saveFile(file: testData, at: path + fileName)

    // When, Then
    #expect(throws: FileRepositoryError.fileAlreadyExists) {
      try useCase.execute(file: testData, fileName: fileName, at: path)
    }
  }

  @Test("잘못된 경로로 다운로드 시도")
  func testDownloadWithInvalidPath() async {
    // Given
    let useCase = DownloadFileUseCaseImpl(repository: mockRepository)
    let invalidPath = "invalid://path/"
    
    // When, Then
    #expect(throws: FileRepositoryError.urlEncodingFailed) {
      try useCase.execute(file: testData, fileName: fileName, at: invalidPath)
    }
  }
}
