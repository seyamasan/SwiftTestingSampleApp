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
        // A Boolean value that indicates whether a test method should continue running after a failure occurs.
        continueAfterFailure = false // 失敗が発生した後もテスト メソッドの実行を継続するか
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    @MainActor
    func testSearchViewInitialUI() throws {
        // Given
        // Launch the application.(アプリを起動する)
        let app = XCUIApplication()
        app.launch()
        
        // When
        // Get each UI element(それぞれのUIの要素を取得)
        let navigationBarsTitle = app.navigationBars["GitHub Repository Search"]
        let textfieldImage = app.images["search.searchTextFieldImage"]
        let textfield = app.textFields["search.searchTextField"]
        
        // Then
        // Check if the necessary UI is present at screen startup(画面起動時に必要なUIが存在しているか確認)
        XCTAssertTrue(navigationBarsTitle.exists)
        XCTAssertTrue(textfieldImage.exists)
        XCTAssertTrue(textfield.exists)
    }
    
    @MainActor
    func testSearchViewSearchRepository() throws {
        // Given
        let app = XCUIApplication()
        app.launchArguments.append("UI_TEST") // Added arguments passed to the application at startup.(起動時にアプリケーションに渡される引数を追加)
        app.launch()
        
        // When
        let list = app.collectionViews["search.repositoryList"]
        let avatarImage0 = app.otherElements["search.avatarImage0"]
        let fullNameText0 = app.staticTexts["search.fullNameText0"]
        let avatarImage1 = app.otherElements["search.avatarImage1"]
        let fullNameText1 = app.staticTexts["search.fullNameText1"]
        
        let textfield = app.textFields["search.searchTextField"]
        textfield.tap()
        textfield.typeText("multiple")
        app.keyboards.buttons["search"].tap() // Tap the search button on the keyboard.(キーボードの検索ボタンをタップ)
        
        // Then
        // Waits for the specified time until the element is present.(要素が存在するまで指定された時間待機します)
        XCTAssertTrue(list.waitForExistence(timeout: 1))
        XCTAssertTrue(avatarImage0.waitForExistence(timeout: 1))
        XCTAssertTrue(fullNameText0.waitForExistence(timeout: 1))
        XCTAssertTrue(avatarImage1.waitForExistence(timeout: 1))
        XCTAssertTrue(fullNameText1.waitForExistence(timeout: 1))
        
        XCTAssertEqual(fullNameText0.label, "test/repo1")
        XCTAssertEqual(fullNameText1.label, "test/repo2")
    }
    
    @MainActor
    func testDetailViewInitialUI() throws {
        // Given
        let app = XCUIApplication()
        app.launchArguments.append("UI_TEST") // Added arguments passed to the application at startup.(起動時にアプリケーションに渡される引数を追加)
        app.launch()
        
        // When
        let searchFullNameText0 = app.staticTexts["search.fullNameText0"]
        let navigationBarsTitle = app.navigationBars["Detail"]
        let avatarImage = app.otherElements["detail.avatarImage"]
        let fullName = app.staticTexts["detail.fullName"]
        let languageImage = app.images["detail.languageImage"]
        let languageText = app.staticTexts["detail.languageText"]
        
        let iconStars = app.images["detail.statView.icon.Stars"]
        let valueStars = app.staticTexts["detail.statView.value.Stars"]
        let labelStars = app.staticTexts["detail.statView.label.Stars"]
        
        let iconWatchers = app.images["detail.statView.icon.Watchers"]
        let valueWatchers = app.staticTexts["detail.statView.value.Watchers"]
        let labelWatchers = app.staticTexts["detail.statView.label.Watchers"]
        
        let iconForks = app.images["detail.statView.icon.Forks"]
        let valueForks = app.staticTexts["detail.statView.value.Forks"]
        let labelForks = app.staticTexts["detail.statView.label.Forks"]
        
        
        let textfield = app.textFields["search.searchTextField"]
        textfield.tap()
        textfield.typeText("single")
        app.keyboards.buttons["search"].tap()
        
        // Then
        XCTAssertTrue(searchFullNameText0.waitForExistence(timeout: 1))
        
        // When
        searchFullNameText0.tap() // Tapping should take you to DetailView.(タップしたらDetailViewに遷移するはず)
        
        // Then
        XCTAssertTrue(navigationBarsTitle.exists)
        XCTAssertTrue(avatarImage.waitForExistence(timeout: 1))
        XCTAssertTrue(fullName.waitForExistence(timeout: 1))
        XCTAssertTrue(languageImage.waitForExistence(timeout: 1))
        XCTAssertTrue(languageText.waitForExistence(timeout: 1))
        
        XCTAssertTrue(iconStars.waitForExistence(timeout: 1))
        XCTAssertTrue(valueStars.waitForExistence(timeout: 1))
        XCTAssertTrue(labelStars.waitForExistence(timeout: 1))
        
        XCTAssertTrue(iconWatchers.waitForExistence(timeout: 1))
        XCTAssertTrue(valueWatchers.waitForExistence(timeout: 1))
        XCTAssertTrue(labelWatchers.waitForExistence(timeout: 1))
        
        XCTAssertTrue(iconForks.waitForExistence(timeout: 1))
        XCTAssertTrue(valueForks.waitForExistence(timeout: 1))
        XCTAssertTrue(labelForks.waitForExistence(timeout: 1))
        
        XCTAssertEqual(fullName.label, "test/repo")
        XCTAssertEqual(languageText.label, "Swift")
        XCTAssertEqual(valueStars.label, "100")
        XCTAssertEqual(valueWatchers.label, "50")
        XCTAssertEqual(valueForks.label, "25")
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
