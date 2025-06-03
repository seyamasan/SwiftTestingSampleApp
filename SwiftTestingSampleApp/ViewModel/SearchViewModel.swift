//
//  SearchViewModel.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/06/03.
//

import Observation

@Observable
class SearchViewModel {
    private(set) var _repoList: [GitHubRepo] = []
    private let _dataSource = GitHubRepositoryDataSource()
        
    func searchRepositories(quely: String) async {
        guard !quely.isEmpty else { return }
        do {
            let repos = try await _dataSource.fetchRepositories(quely: quely)
            self._repoList = repos
        } catch {
            print("エラー: \(error)")
        }
    }
}
