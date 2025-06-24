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
                    forksCount: 25
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
            #expect(viewModel.errorMessage == nil)
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
            #expect(viewModel.errorMessage == nil)
        }
    }
    
    @Suite(
        "Abnormal"
    )
    struct AbnormalTests {
        
        @Test("An error of type GitHubAPIError should occur")
        func failureGitHubAPIError() async {
            // Given
            let fakeError = GitHubAPIError.clientError
            let fakeRepository = FakeGitHubSearchRepository(
                fakeResult: nil,
                fakeError: fakeError
            )
            let viewModel = SearchViewModel(repository: fakeRepository)
            
            // When
            await viewModel.searchRepositories(query: "URL")
            
            // Then
            #expect(viewModel._repositories.count == 0)
            #expect(viewModel._isSearching == false)
            #expect(viewModel.errorMessage == fakeError.getDescription())
        }
        
        // I don't know how to force the error to occur.
        // エラーを発生させる方法が分からないので、強制的に発生させる。
        @Test("Invalid URL error")
        func failureInvalidURL() async {
            // Given
            let fakeErrorMessage = CommonError.invalidURL.getDescription()
            let fakeRepository = FakeGitHubSearchRepository(
                fakeResult: nil,
                fakeError: URLError(.badURL)
            )
            let viewModel = SearchViewModel(repository: fakeRepository)
            
            // When
            await viewModel.searchRepositories(query: "URL")
            
            // Then
            #expect(viewModel._repositories.count == 0)
            #expect(viewModel._isSearching == false)
            #expect(viewModel.errorMessage == fakeErrorMessage)
        }
        
        @Test("Unexpected Error")
        func failureUnexpectedError() async {
            // Given
            let fakeError = CommonError.unexpectedError
            let fakeRepository = FakeGitHubSearchRepository(
                fakeResult: nil,
                fakeError: fakeError
            )
            let viewModel = SearchViewModel(repository: fakeRepository)
            
            // When
            await viewModel.searchRepositories(query: "Unexpected Error")
            
            // Then
            #expect(viewModel._repositories.count == 0)
            #expect(viewModel._isSearching == false)
            #expect(viewModel.errorMessage == fakeError.getDescription())
        }
    }
}
