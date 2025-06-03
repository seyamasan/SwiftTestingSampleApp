//
//  GitHubRepositoryDataSourceProtocol.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/06/03.
//

protocol GitHubRepositoryDataSourceProtocol {
    func fetchRepositories(quely: String) async throws -> [GitHubRepo]
}
