//
//  GitHubSearchRepositoryTests.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/06/09.
//

import Foundation
import Testing
@testable import SwiftTestingSampleApp

@Suite(
    "Unit testing of GitHubSearchRepository"
)
struct GitHubSearchRepositoryTests {
    @Suite(
        "Normal"
    )
    struct NormalTests {
        @Test("Successful fetchRepositories")
        func fetchRepositoriesSuccess() async throws {
            // Given
            let fakeDataSource = FakeGitHubRepositoryDataSource(
                fakeResult: [GitHubRepositoryFakeData.gitHubSearchRepositoryForNormalTest],
                fakeError: nil
            )
            let repository = GitHubSearchRepository(dataSource: fakeDataSource)
            let fakeRequest = URLRequest(url: URL(string: "https://test.com/fake")!) // Anything.
            
            // When
            let repositories = try await repository.fetchRepositories(request: fakeRequest)
            
            // Then
            #expect(repositories.count == 1)
        }
    }
    
    @Suite(
        "Abnormal"
    )
    struct AbnormalTests {
        @Test("Propagation of errors")
        func fetchRepositoriesError() async {
            // Given
            let fakeDataSource = FakeGitHubRepositoryDataSource(fakeResult:nil, fakeError: GitHubAPIError.clientError)
            let repository = GitHubSearchRepository(dataSource: fakeDataSource)
            let fakeRequest = URLRequest(url: URL(string: "https://test.com/fake")!)
            
            // Then
            await #expect(throws: GitHubAPIError.clientError) {
                // When
                _ = try await repository.fetchRepositories(request: fakeRequest)
            }
        }
    }
}
