//
//  GitHubAPIErrorTests.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/06/15.
//

import Testing
@testable import SwiftTestingSampleApp

@Suite(
    "Unit testing of GitHubAPIError"
)
struct GitHubAPIErrorTests {
    @Suite(
        "Normal"
    )
    struct NormalTests {
        @Test("Validate error messages obtained with getDescription()")
        func testErrorDescriptions() async {
            // Then
            #expect(GitHubAPIError.responseError.getDescription() == "An error occurred during the search.")
            #expect(GitHubAPIError.clientError.getDescription() == "A client error has occurred.")
            #expect(GitHubAPIError.serverError.getDescription() == "A server error has occurred.")
            #expect(GitHubAPIError.decodingError.getDescription() == "Data parsing failed.")
            #expect(GitHubAPIError.networkError.getDescription() == "You may not be connected to the Internet.")
            #expect(GitHubAPIError.unknownError.getDescription() == "Unknown error.")
        }
    }
}
