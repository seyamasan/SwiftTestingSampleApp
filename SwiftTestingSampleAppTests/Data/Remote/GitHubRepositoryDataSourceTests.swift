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
        return GenerateFakeData.generateForGitHubRepositoryDataSource()
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
            
            #expect(repositories[1].fullName == "test/repo2")
            #expect(repositories[1].language == "Kotlin")
            #expect(repositories[1].owner?.avatarUrl == "https://example.com/avatar2.png")
            #expect(repositories[1].stargazersCount == 200)
            #expect(repositories[1].watchersCount == 150)
            #expect(repositories[1].forksCount == 75)
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
        
        @Test("Network Error", arguments: [
            URLRequest(url: URL(string: "https://test.com/network_error")!)
        ])
        func failureNetworkError(request: URLRequest) async {
            // Given
            let dataSource = GitHubRepositoryDataSource(session: self.fakeSession)
            
            // Then
            // Verify that networkError is thrown(networkErrorがスローされることを検証)
            await #expect(throws: GitHubAPIError.networkError) {
                // When
                _ = try await dataSource.fetchRepositories(request: request)
            }
        }
        
        @Test("Response Error", arguments: [
            URLRequest(url: URL(string: "https://test.com/response_error")!)
        ])
        func failureResponseError(request: URLRequest) async {
            // Given
            let dataSource = GitHubRepositoryDataSource(session: self.fakeSession)
            
            // Then
            await #expect(throws: GitHubAPIError.responseError) {
                // When
                _ = try await dataSource.fetchRepositories(request: request)
            }
        }
        
        @Test("Decord exception", arguments: [
            URLRequest(url: URL(string: "https://test.com/invalid_json")!)
        ])
        func failureInvalidJSON(request: URLRequest) async {
            // Given
            let dataSource = GitHubRepositoryDataSource(session: self.fakeSession)
            
            // Then
            await #expect(throws: GitHubAPIError.decodingError) {
                // When
                _ = try await dataSource.fetchRepositories(request: request)
            }
        }
        
        @Test("Validate client error bounds", arguments: [[
            URLRequest(url: URL(string: "https://test.com/client_error_1")!),
            URLRequest(url: URL(string: "https://test.com/client_error_2")!),
        ]])
        func failureClientError(requests: [URLRequest]) async {
            // Given
            let dataSource = GitHubRepositoryDataSource(session: self.fakeSession)
            
            for request in requests {
                // Then
                await #expect(throws: GitHubAPIError.clientError) {
                    // When
                    _ = try await dataSource.fetchRepositories(request: request)
                }
            }
        }
        
        @Test("Validate server error bounds", arguments: [[
            URLRequest(url: URL(string: "https://test.com/server_error_1")!),
            URLRequest(url: URL(string: "https://test.com/server_error_2")!)
        ]])
        func failureServerError(requests: [URLRequest]) async {
            // Given
            let dataSource = GitHubRepositoryDataSource(session: self.fakeSession)
            
            for request in requests {
                // Then
                await #expect(throws: GitHubAPIError.serverError) {
                    // When
                    _ = try await dataSource.fetchRepositories(request: request)
                }
            }
        }
        
        @Test("Unknown Error", arguments: [
            URLRequest(url: URL(string: "https://test.com/unknown_error")!)
        ])
        func failureUnknownError(request: URLRequest) async {
            // Given
            let dataSource = GitHubRepositoryDataSource(session: self.fakeSession)
            
            // Then
            await #expect(throws: GitHubAPIError.unknownError) {
                // When
                _ = try await dataSource.fetchRepositories(request: request)
            }
        }
    }
}
