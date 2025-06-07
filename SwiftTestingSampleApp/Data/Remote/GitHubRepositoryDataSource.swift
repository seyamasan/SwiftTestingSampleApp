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
    
    private let session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchRepositories(request: URLRequest) async throws -> [GitHubRepo] {
        let (data, _) = try await self.session.data(for: request)
        
        let result = try JSONDecoder().decode(SearchResponse.self, from: data)
        return result.items
    }
}
