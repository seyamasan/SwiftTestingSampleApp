//
//  GitHubRepo.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/06/03.
//

import Foundation

struct GitHubRepo: Decodable, Hashable {
    
    struct Owner: Decodable, Hashable {
        let avatarUrl: String
        
        enum CodingKeys: String, CodingKey {
            case avatarUrl = "avatar_url"
        }
    }
    
    let fullName: String
    let language: String?
    let owner: Owner?
    
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case language
        case owner
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case forksCount = "forks_count"
    }
}
