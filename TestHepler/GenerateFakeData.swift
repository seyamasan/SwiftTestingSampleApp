//
//  GenerateFakeData.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/07/13.
//

import Foundation

class GenerateFakeData {
    static func generateForUITest() -> URLSession {
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
    
    static func generateForGitHubRepositoryDataSource() -> URLSession {
        FakeURLProtocol.testURLs = [
            URL(string: "https://test.com/single"): (
                error: nil,
                data: GitHubRepositoryFakeData.singleResponse.data(using: .utf8)!,
                response: HTTPURLResponse(url: URL(string: "https://test.com/single")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            ),
            URL(string: "https://test.com/multiple"): (
                error: nil,
                data: GitHubRepositoryFakeData.multipleResponse.data(using: .utf8)!,
                response: HTTPURLResponse(url: URL(string: "https://test.com/multiple")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            ),
            URL(string: "https://test.com/empty"): (
                error: nil,
                data: GitHubRepositoryFakeData.emptyResponse.data(using: .utf8)!,
                response: HTTPURLResponse(url: URL(string: "https://test.com/empty")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            ),
            URL(string: "https://test.com/network_error"): (
                error: GitHubAPIError.networkError,
                data: nil,
                response: nil
            ),
            URL(string: "https://test.com/response_error"): (
                error: nil,
                data: nil,
                response: URLResponse(url: URL(string: "https://test.com/response_error")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
            ),
            URL(string: "https://test.com/invalid_json"): (
                error: nil,
                data: GitHubRepositoryFakeData.invalidJson.data(using: .utf8)!,
                response: HTTPURLResponse(url: URL(string: "https://test.com/invalid_json")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            ),
            URL(string: "https://test.com/client_error_1"): (
                error: nil,
                data: nil,
                response: HTTPURLResponse(url: URL(string: "https://test.com/client_error_1")!, statusCode: 400, httpVersion: nil, headerFields: nil)!
            ),
            URL(string: "https://test.com/client_error_2"): (
                error: nil,
                data: nil,
                response: HTTPURLResponse(url: URL(string: "https://test.com/client_error_2")!, statusCode: 499, httpVersion: nil, headerFields: nil)!
            ),
            URL(string: "https://test.com/server_error_1"): (
                error: nil,
                data: nil,
                response: HTTPURLResponse(url: URL(string: "https://test.com/server_error_1")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
            ),
            URL(string: "https://test.com/server_error_2"): (
                error: nil,
                data: nil,
                response: HTTPURLResponse(url: URL(string: "https://test.com/server_error_2")!, statusCode: 599, httpVersion: nil, headerFields: nil)!
            ),
            URL(string: "https://test.com/unknown_error"): (
                error: nil,
                data: nil,
                response: HTTPURLResponse(url: URL(string: "https://test.com/unknown_error")!, statusCode: 300, httpVersion: nil, headerFields: nil)!
            )
        ]
        
        let config = URLSessionConfiguration.default
        config.protocolClasses = [FakeURLProtocol.self]
        return URLSession(configuration: config)
    }
}
