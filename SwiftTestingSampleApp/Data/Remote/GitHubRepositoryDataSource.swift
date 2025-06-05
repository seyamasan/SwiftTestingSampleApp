//
//  GitHubRepositoryDataSource.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/06/03.
//

import Foundation

actor GitHubRepositoryDataSource: GitHubRepositoryDataSourceProtocol {
    
    private struct SearchResponse: Decodable {
        let items: [GitHubRepo]
    }
    
    func fetchRepositories(url: URL) async throws -> [GitHubRepo] {
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let result = try JSONDecoder().decode(SearchResponse.self, from: data)
        return result.items
    }
}
