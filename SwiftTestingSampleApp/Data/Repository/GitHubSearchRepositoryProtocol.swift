//
//  GitHubSearchRepositoryProtocol.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/06/05.
//

import Foundation

protocol GitHubSearchRepositoryProtocol {
    func fetchRepositories(url: URL) async throws -> [GitHubRepo]
}
