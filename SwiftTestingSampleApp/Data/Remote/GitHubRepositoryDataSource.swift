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
        do {
            let (data, response) = try await self.session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw GitHubAPIError.responseError
            }
            
            switch httpResponse.statusCode {
            case 200:
                // Success
                do {
                    let result = try JSONDecoder().decode(SearchResponse.self, from: data)
                    return result.items
                } catch {
                    throw GitHubAPIError.decodingError
                }
            case 400...499:
                // Client Error
                throw GitHubAPIError.clientError
            case 500...599:
                // Server Error
                throw GitHubAPIError.serverError
            default:
                throw GitHubAPIError.unknownError
            }
        } catch let error as GitHubAPIError {
            throw error
        } catch {
            throw GitHubAPIError.networkError
        }
    }
}
