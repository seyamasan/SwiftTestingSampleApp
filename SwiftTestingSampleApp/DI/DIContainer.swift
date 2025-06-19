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
        let fakeUrlSession = self.setUpFakeURLSession()
        let dataSource = GitHubRepositoryDataSource(session: fakeUrlSession)
        let repository = GitHubSearchRepository(dataSource: dataSource)
        return SearchViewModel(repository: repository)
    }
    
    private func setUpFakeURLSession() -> URLSession {
        // Make Fake for testing.(テストに必要なFakeを作っておく)
        FakeURLProtocol.testURLs = [
            URL(string: "\(GitHubApiUrl.baseSearchRepositoriesUrl)single"): (
                error: nil,
                data: GitHubRepositoryFakeData.singleResponse.data(using: .utf8)!,
                response: HTTPURLResponse(url: URL(string: "\(GitHubApiUrl.baseSearchRepositoriesUrl)single")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            ),
            URL(string: "\(GitHubApiUrl.baseSearchRepositoriesUrl)multiple"): (
                error: nil,
                data: GitHubRepositoryFakeData.multipleResponse.data(using: .utf8)!,
                response: HTTPURLResponse(url: URL(string: "\(GitHubApiUrl.baseSearchRepositoriesUrl)multiple")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            ),
            URL(string: "\(GitHubApiUrl.baseSearchRepositoriesUrl)server_error"): (
                error: nil,
                data: nil,
                response: HTTPURLResponse(url: URL(string: "\(GitHubApiUrl.baseSearchRepositoriesUrl)server_error")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
            )
        ]
        
        let config = URLSessionConfiguration.default
        config.protocolClasses = [FakeURLProtocol.self]
        return URLSession(configuration: config)
    }
}
