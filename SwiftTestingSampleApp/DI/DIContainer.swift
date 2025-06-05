//
//  DIContainer.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/06/05.
//

class DIContainer {
    static let shared = DIContainer()
    
    func makeSearchViewModel() -> SearchViewModel {
        let dataSource = GitHubRepositoryDataSource()
        let repository = GitHubSearchRepository(dataSource: dataSource)
        return SearchViewModel(repository: repository)
    }
}
