//
//  GitHubRepositoryDataSourceTests.swift
//  SwiftTestingSampleAppTests
//
//  Created by 瀬山皐太 on 2025/06/07.
//

import Testing
import Foundation
@testable import SwiftTestingSampleApp

// Define test groups by granting @Suite (@Suiteを付与することでテストグループを定義)
@Suite(
    "Unit testing of GitHubRepositoryDataSource"
)
struct GitHubRepositoryDataSourceTests {
    
    static func setUp() -> URLSession {
        // Make Fake for testing.(テストに必要なFakeを作っておく)
        FakeURLProtocol.testURLs = [
            URL(string: "https://test.com/single"): GitHubRepositoryFakeData.singleResponse.data(using: .utf8)!,
            URL(string: "https://test.com/multiple"): GitHubRepositoryFakeData.multipleResponse.data(using: .utf8)!,
            URL(string: "https://test.com/empty"): GitHubRepositoryFakeData.emptyResponse.data(using: .utf8)!,
            URL(string: "https://test.com/invalid_json"): GitHubRepositoryFakeData.invalidJson.data(using: .utf8)!
        ]
        
        let config = URLSessionConfiguration.default
        config.protocolClasses = [FakeURLProtocol.self]
        return URLSession(configuration: config)
    }
    
    @Suite(
        "Normal"
    )
    struct NormalTests {
        private let fakeSession: URLSession
        
        init() {
            self.fakeSession = GitHubRepositoryDataSourceTests.setUp()
        }
        
        @Test("Get a single data", arguments: [
            // Specify the required values for each test pattern in argments.
            // テストパターンごとに必要な値をargmentsに指定する
            URLRequest(url: URL(string: "https://test.com/single")!)
        ])
        func successSingleRepository(
            request: URLRequest // Create a request with the FakeURL you created.(作っておいたFakeURLでリクエストを作成)
        ) async throws {
            // Given
            // Initialize data source using fake session.(Fakeセッションを使用してデータソースを初期化)
            let dataSource = GitHubRepositoryDataSource(session: self.fakeSession)
            
            // When
            let repositories = try await dataSource.fetchRepositories(request: request)
            
            // Then
            // Verify results.(結果を検証)
            #expect(repositories.count == 1)
            #expect(repositories[0].fullName == "test/repo")
            #expect(repositories[0].language == "Swift")
            #expect(repositories[0].owner?.avatarUrl == "https://example.com/avatar.png")
            #expect(repositories[0].stargazersCount == 100)
            #expect(repositories[0].watchersCount == 50)
            #expect(repositories[0].forksCount == 25)
            #expect(repositories[0].openIssuesCount == 10)
        }
        
        @Test("Gets multiple repositories", arguments: [
            URLRequest(url: URL(string: "https://test.com/multiple")!)
        ])
        func successMultipleRepositories(request: URLRequest) async throws {
            // Given
            let dataSource = GitHubRepositoryDataSource(session: self.fakeSession)
            
            // When
            let repositories = try await dataSource.fetchRepositories(request: request)
            
            // Then
            #expect(repositories.count == 2)
            #expect(repositories[0].fullName == "test/repo1")
            #expect(repositories[0].language == "Swift")
            #expect(repositories[0].owner?.avatarUrl == "https://example.com/avatar1.png")
            #expect(repositories[0].stargazersCount == 100)
            #expect(repositories[0].watchersCount == 50)
            #expect(repositories[0].forksCount == 25)
            #expect(repositories[0].openIssuesCount == 10)
            
            #expect(repositories[1].fullName == "test/repo2")
            #expect(repositories[1].language == "Kotlin")
            #expect(repositories[1].owner?.avatarUrl == "https://example.com/avatar2.png")
            #expect(repositories[1].stargazersCount == 200)
            #expect(repositories[1].watchersCount == 150)
            #expect(repositories[1].forksCount == 75)
            #expect(repositories[1].openIssuesCount == 20)
        }

        @Test("Get empty result", arguments: [
            URLRequest(url: URL(string: "https://test.com/empty")!)
        ])
        func successEmptyRepositories(request: URLRequest) async throws {
            // Given
            let dataSource = GitHubRepositoryDataSource(session: self.fakeSession)
                    
            // When
            let repositories = try await dataSource.fetchRepositories(request: request)
            
            // Then
            #expect(repositories.count == 0)
        }
    }
    
    @Suite(
        "Abnormal"
    )
    struct AbnormalTests {
        private let fakeSession: URLSession
        
        init() {
            self.fakeSession = GitHubRepositoryDataSourceTests.setUp()
        }
        
        @Test("Decord exception", arguments: [
            URLRequest(url: URL(string: "https://test.com/invalid_json")!)
        ])
        func failureInvalidJSON(request: URLRequest) async throws {
            // Given
            let dataSource = GitHubRepositoryDataSource(session: self.fakeSession)
            
            // Then
            // Verify that DecodingError is thrown(DecodingErrorがスローされることを検証)
            await #expect(throws: DecodingError.self) {
                // When
                _ = try await dataSource.fetchRepositories(request: request)
            }
        }
    }
}
