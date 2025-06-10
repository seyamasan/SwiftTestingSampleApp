//
//  SearchViewModelTests.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/06/10.
//

import Foundation
import Testing
@testable import SwiftTestingSampleApp

@Suite(
    "Unit testing of SearchViewModel"
)
struct SearchViewModelTests {
    
    static func setUpNormal() -> SearchViewModel {
        let fakeRepository = FakeGitHubSearchRepository(
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
        
        return SearchViewModel(repository: fakeRepository)
    }
    
    @Suite(
        "Normal"
    )
    struct NormalTests {
        @Test("Successful searchRepositories")
        func searchRepositoriesSuccess() async {
            // Given
            let viewModel = SearchViewModelTests.setUpNormal()
            
            // When
            await viewModel.searchRepositories(query: "fake")
            
            // Then
            #expect(viewModel._repositories.count == 1)
            #expect(viewModel._isSearching == false)
        }
        
        @Test("Do not perform a search for an empty query")
        func searchRepositoriesEmptyQuery() async {
            // Given
            let viewModel = SearchViewModelTests.setUpNormal()
            
            // When
            await viewModel.searchRepositories(query: "")
            
            // Then
            #expect(viewModel._repositories.count == 0)
            #expect(viewModel._isSearching == false)
        }
    }
}
