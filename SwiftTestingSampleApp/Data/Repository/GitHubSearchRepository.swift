//
//  GitHubSearchRepository.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/06/05.
//

import Foundation

class GitHubSearchRepository: GitHubSearchRepositoryProtocol {
    
    private let _dataSource: GitHubRepositoryDataSourceProtocol
    
    init(dataSource: GitHubRepositoryDataSourceProtocol) {
        self._dataSource = dataSource
    }
    
    func fetchRepositories(url: URL) async throws -> [GitHubRepo] {
        try await self._dataSource.fetchRepositories(url: url)
    }
}
