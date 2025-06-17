//
//  SwiftTestingSampleAppUITests.swift
//  SwiftTestingSampleAppUITests
//
//  Created by 瀬山皐太 on 2025/06/03.
//

import XCTest

final class SwiftTestingSampleAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // Launch the application.(アプリを起動する)
        let app = XCUIApplication()
        app.launchArguments.append("UI_TEST") // Added arguments passed to the application at startup.(起動時にアプリケーションに渡される引数を追加)
        app.launch()

        let textfield = app.textFields["search.searchTextField"] // Get the UI elements of SearchView's TextField.(SearchViewのTextFieldのUI要素を取ってくる)
        textfield.tap()
        textfield.typeText("single")
        
        // Tap the search button on the keyboard.(キーボードの検索ボタンをタップ)
        app.keyboards.buttons["search"].tap()
        
        
        let list = app.collectionViews["search.repositoryList"]
        // Waits for the specified time until the element is present.(要素が存在するまで指定された時間待機します)
        XCTAssertTrue(list.waitForExistence(timeout: 5))
    }

//    @MainActor
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
