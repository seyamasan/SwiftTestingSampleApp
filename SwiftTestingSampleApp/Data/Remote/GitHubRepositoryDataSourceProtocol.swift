//
//  GitHubRepositoryDataSourceProtocol.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/06/03.
//

import Foundation

protocol GitHubRepositoryDataSourceProtocol {
    func fetchRepositories(request: URLRequest) async throws -> [GitHubRepo]
}
