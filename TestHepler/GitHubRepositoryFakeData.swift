//
//  GitHubRepositoryFakeData.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/06/07.
//

final class GitHubRepositoryFakeData {
    static let singleResponse = """
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
                "forks_count": 25
            }
        ]
    }
    """
    
    static let multipleResponse = """
    {
        "items": [
            {
                "full_name": "test/repo1",
                "language": "Swift",
                "owner": {
                    "avatar_url": "https://example.com/avatar1.png"
                },
                "stargazers_count": 100,
                "watchers_count": 50,
                "forks_count": 25
            },
            {
                "full_name": "test/repo2",
                "language": "Kotlin",
                "owner": {
                    "avatar_url": "https://example.com/avatar2.png"
                },
                "stargazers_count": 200,
                "watchers_count": 150,
                "forks_count": 75
            }
        ]
    }
    """
    
    static let emptyResponse = """
    {
        "items": []
    }
    """
    
    static let invalidJson = "invalidJson"
    
    static let gitHubSearchRepositoryForNormalTest: GitHubRepo = GitHubRepo(
        fullName: "test/repo",
        language: "Swift",
        owner: GitHubRepo.Owner(avatarUrl: "https://example.com/avatar.png"),
        stargazersCount: 100,
        watchersCount: 50,
        forksCount: 25
    )
    
    static let searchViewModelForNormalTest: GitHubRepo = GitHubRepo(
        fullName: "test/repo",
        language: "Swift",
        owner: GitHubRepo.Owner(avatarUrl: "https://example.com/avatar.png"),
        stargazersCount: 100,
        watchersCount: 50,
        forksCount: 25
    )
}
