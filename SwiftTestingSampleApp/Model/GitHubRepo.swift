//
//  GitHubRepo.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/06/03.
//

struct GitHubRepo: Decodable {
//    let name: String
    let fullName: String
    let language: String?

    enum CodingKeys: String, CodingKey {
//        case name
        case fullName = "full_name"
        case language
    }
}
