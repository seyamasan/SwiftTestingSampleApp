//
//  FakeGitHubRepositoryDataSource.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/06/09.
//

import Foundation
@testable import SwiftTestingSampleApp

// Fake class for GitHubRepositoryDataSource.
actor FakeGitHubRepositoryDataSource: GitHubRepositoryDataSourceProtocol {
    
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
