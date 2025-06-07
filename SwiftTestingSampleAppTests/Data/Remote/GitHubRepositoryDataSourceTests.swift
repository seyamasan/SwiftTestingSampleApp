//
//  GitHubRepositoryDataSourceTests.swift
//  SwiftTestingSampleAppTests
//
//  Created by 瀬山皐太 on 2025/06/07.
//

import Testing
import Foundation
@testable import SwiftTestingSampleApp

struct GitHubRepositoryDataSourceTests {
    
    private let session: URLSession
    
    init() {
        // Make Fake for testing.(テストに必要なFakeを作っておく)
        URLProtocolFake.testURLs = [
            URL(string: "https://test.com/a"): GitHubRepositoryFakeData.successResponse.data(using: .utf8)!
        ]
        
        let config = URLSessionConfiguration.default
        config.protocolClasses = [URLProtocolFake.self]
        self.session = URLSession(configuration: config)
    }

    @Test("Normal - Get a single data")
    func fetchRepositories() async throws {
        // Initialize data source using fake session.(Fakeセッションを使用してデータソースを初期化)
        let dataSource = GitHubRepositoryDataSource(session: self.session)
        
        // Create a request with the FakeURL you created.(作っておいたFakeURLでリクエストを作成)
        let request = URLRequest(url: URL(string: "https://test.com/a")!)
        
        let repositories = try await dataSource.fetchRepositories(request: request)
        
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

}
