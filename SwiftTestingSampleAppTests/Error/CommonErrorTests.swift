//
//  CommonErrorTests.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/06/15.
//

import Testing
@testable import SwiftTestingSampleApp

@Suite(
    "Unit testing of CommonError"
)
struct CommonErrorTests {
    @Suite(
        "Normal"
    )
    struct NormalTests {
        @Test("Validate error messages obtained with getDescription()")
        func testErrorDescriptions() {
            // Then
            #expect(CommonError.invalidURL.getDescription() == "Invalid URL.")
            #expect(CommonError.unexpectedError.getDescription() == "An unexpected error has occurred.")
        }
    }
}
