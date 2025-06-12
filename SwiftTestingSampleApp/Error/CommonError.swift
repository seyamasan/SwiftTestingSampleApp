//
//  CommonError.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/06/11.
//

enum CommonError: Error {
    case invalidURL
    case unexpectedError
    
    func getDescription() -> String {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .unexpectedError:
            return "An unexpected error has occurred."
        }
    }
}
