//
//  SearchViewModel.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/06/03.
//

import Observation
import Foundation

@Observable
class SearchViewModel {
    private let _repository: GitHubSearchRepositoryProtocol
    private(set) var _repositories: [GitHubRepo] = []
    
    private(set) var _isSearching: Bool = false
    
    init(repository: GitHubSearchRepositoryProtocol) {
        self._repository = repository
    }
        
    func searchRepositories(query: String) async {
        guard !query.isEmpty else { return }
        
        self._isSearching = true
        defer { self._isSearching = false } // Hide the progress bar when you are done searching.
        
        do {
            let encodedWord = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            
            let urlString = GitHubApi.baseSearchRepositoriesUrl + encodedWord
            
            guard let url = URL(string: urlString) else {
                throw URLError(.badURL)
            }
            
            self._repositories = try await self._repository.fetchRepositories(request: URLRequest(url: url))
        } catch {
            if let urlError = error as? URLError {
                print("""
                    URLError:
                    Code: \(urlError.code.rawValue)
                    Description: \(urlError.localizedDescription)
                    
                """)
            } else {
                print("""
                    searchRepositories() Error!:
                    Type: \(type(of: error))
                    Description: \(error.localizedDescription)
                """)
            }
        }
    }
}
