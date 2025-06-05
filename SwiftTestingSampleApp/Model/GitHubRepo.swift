//
//  GitHubRepo.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/06/03.
//

import Foundation

struct GitHubRepo: Decodable, Identifiable {
    
    struct Owner: Decodable {
        let avatarUrl: String
        
        enum CodingKeys: String, CodingKey {
            case avatarUrl = "avatar_url"
        }
    }

    let id = UUID()
    
    let fullName: String
    let language: String?
    let owner: Owner?
    
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case language
        case owner
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
    }
}
