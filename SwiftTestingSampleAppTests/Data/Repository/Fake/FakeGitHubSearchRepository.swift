//
//  FakeGitHubSearchRepository.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/06/10.
//

import Foundation
@testable import SwiftTestingSampleApp

// Fake class for GitHubSearchRepository.
class FakeGitHubSearchRepository: GitHubSearchRepositoryProtocol {
    
    private var _fakeResult: [GitHubRepo]?
    private var _fakeError: Error?
    
    init(fakeResult: [GitHubRepo]?, fakeError: Error?) {
        self._fakeResult = fakeResult
        self._fakeError = fakeError
    }
    
    func fetchRepositories(request: URLRequest) async throws -> [GitHubRepo] {
        if let error = self._fakeError {
            throw error
        }
        return self._fakeResult ?? []
    }
}
