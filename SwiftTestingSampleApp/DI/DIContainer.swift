//
//  DIContainer.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/06/05.
//

import Foundation

class DIContainer {
    static let shared = DIContainer()
    
    func makeSearchViewModel() -> SearchViewModel {
        if ProcessInfo.processInfo.arguments.contains("UI_TEST") { // Determine if UI testing.(UIテストかを判定)
            return makeUITestSearchViewModel()
        } else {
            return makeDefaultSearchViewModel()
        }
        
    }
    
    private func makeDefaultSearchViewModel() -> SearchViewModel {
        let dataSource = GitHubRepositoryDataSource()
        let repository = GitHubSearchRepository(dataSource: dataSource)
        return SearchViewModel(repository: repository)
    }
    
    // DI for UI testing(UIテスト用のDI)
    private func makeUITestSearchViewModel() -> SearchViewModel {
        let fakeUrlSession = GenerateFakeData.generateForUITest()
        let dataSource = GitHubRepositoryDataSource(session: fakeUrlSession)
        let repository = GitHubSearchRepository(dataSource: dataSource)
        return SearchViewModel(repository: repository)
    }
}
