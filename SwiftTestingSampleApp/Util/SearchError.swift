//
//  SearchError.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/06/11.
//

enum SearchError {
    case searchError
    
    func getDescription() -> String {
        switch self {
        case .searchError:
            return "Search failed."
        }
    }
}
