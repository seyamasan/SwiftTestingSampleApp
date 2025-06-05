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
    
    init(repository: GitHubSearchRepositoryProtocol) {
        self._repository = repository
    }
        
    func searchRepositories(query: String) async {
        guard !query.isEmpty else { return }
        
        do {
            let encodedWord = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            
            let urlString = GitHubApi.baseSearchRepositoriesUrl + encodedWord
            
            guard let url = URL(string: urlString) else {
                throw URLError(.badURL)
            }
            
            self._repositories = try await self._repository.fetchRepositories(url: url)
        } catch {
            print("エラー: \(error)")
        }
    }
}
