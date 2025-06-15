//
//  GitHubAPIError.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/06/12.
//

enum GitHubAPIError: Error {
    case responseError
    case clientError
    case serverError
    case decodingError
    case networkError
    case unknownError
    
    func getDescription() -> String {
        switch self {
        case .responseError:
            return "An error occurred during the search."
        case .clientError:
            return "A client error has occurred."
        case .serverError:
            return "A server error has occurred."
        case .decodingError:
            return "Data parsing failed."
        case .networkError:
            return "You may not be connected to the Internet."
        case .unknownError:
            return "Unknown error."
        }
    }
}
