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
    
    var errorMessage: String? = nil
    
    init(repository: GitHubSearchRepositoryProtocol) {
        self._repository = repository
    }
        
    func searchRepositories(query: String) async {
        guard !query.isEmpty else { return }
        
        self._isSearching = true
        defer { self._isSearching = false } // Hide the progress bar when you are done searching.
        
        do {
            let encodedWord = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let urlString = GitHubApiUrl.baseSearchRepositoriesUrl + encodedWord
            
            guard let url = URL(string: urlString) else {
                throw URLError(.badURL)
            }
            
            self._repositories = try await self._repository.fetchRepositories(request: URLRequest(url: url))
            
        } catch let error as GitHubAPIError {
            self.errorMessage = error.getDescription()
        } catch let error as URLError {
            self.errorMessage = CommonError.invalidURL.getDescription()
            print(error.localizedDescription)
        } catch {
            self.errorMessage = CommonError.unexpectedError.getDescription()
        }
    }
}
