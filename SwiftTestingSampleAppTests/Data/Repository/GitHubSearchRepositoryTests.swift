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
                fakeResult: [
                    GitHubRepo(
                        fullName: "test/repo",
                        language: "Swift",
                        owner: GitHubRepo.Owner(avatarUrl: "https://example.com/avatar.png"),
                        stargazersCount: 100,
                        watchersCount: 50,
                        forksCount: 25,
                        openIssuesCount: 10
                    )
                ],
                fakeError: nil
            )
            
            let fakeRequest = URLRequest(url: URL(string: "https://test.com/fake")!) // Anything.
            
            // When
            let repositories = try await fakeDataSource.fetchRepositories(request: fakeRequest)
            
            // Then
            #expect(repositories.count == 1)
        }
    }
    
    @Suite(
        "Abnormal"
    )
    struct AbnormalTests {
        @Test("Propagation of errors")
        func fetchRepositoriesError() async throws {
            // Given
            let fakeDataSource = FakeGitHubRepositoryDataSource(fakeResult:nil, fakeError: NSError(domain: "test", code: -1))
            let fakeRequest = URLRequest(url: URL(string: "https://test.com/fake")!)
            
            // Then
            await #expect(throws: Error.self) {
                // When
                _ = try await fakeDataSource.fetchRepositories(request: fakeRequest)
            }
        }
    }
}
