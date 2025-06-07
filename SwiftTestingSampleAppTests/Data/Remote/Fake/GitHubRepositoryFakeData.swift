//
//  GitHubRepositoryFakeData.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/06/07.
//

final class GitHubRepositoryFakeData {
    static let successResponse = """
    {
        "items": [
            {
                "id": 1,
                "full_name": "test/repo",
                "language": "Swift",
                "owner": {
                    "avatar_url": "https://example.com/avatar.png"
                },
                "stargazers_count": 100,
                "watchers_count": 50,
                "forks_count": 25,
                "open_issues_count": 10
            }
        ]
    }
    """
}
