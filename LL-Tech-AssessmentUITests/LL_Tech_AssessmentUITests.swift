//
//  LL_Tech_AssessmentUITests.swift
//  LL-Tech-AssessmentUITests
//
//  Created by Allan Wright on 4/3/20.
//  Copyright © 2020 Allan Wright. All rights reserved.
//

import XCTest
import CoreData
@testable import LL_Tech_Assessment

class LL_Tech_AssessmentUITests: XCTestCase {
    let app: XCUIApplication = XCUIApplication()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app.launch()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddJeans() {
        XCTAssert(app.buttons["plus.circle"].isHittable)
        app.navigationBars["List"].buttons["plus.circle"].tap()

        let appTextFields = app.tables.textFields
        XCTAssert(appTextFields["Dress, T-Shirt, ..."].isHittable)
        appTextFields["Dress, T-Shirt, ..."].tap()
        appTextFields["Dress, T-Shirt, ..."].typeText("Jeans")

        XCTAssert(app.buttons["Save"].isHittable)
        app.navigationBars["Add"].buttons["Save"].tap()

        XCTAssertNotNil(app.tables.children(matching: .cell).element(boundBy: 0).staticTexts["Jeans"], "Jeans were not added to list")
    }

    func testCancelAddGarment() {
        app.navigationBars["List"].buttons["plus.circle"].tap()
        app.navigationBars["Add"].buttons["Save"].tap()

        XCTAssert(app.buttons["Close"].isHittable)
        app.alerts["No Name"].scrollViews.otherElements.buttons["Close"].tap()

        XCTAssert(app.buttons["plus.circle"].isHittable, "Close without save did not close the add garment view")
    }

    func testSort() {
        app.navigationBars["List"].buttons["plus.circle"].tap()
        app.tables.textFields["Dress, T-Shirt, ..."].tap()
        app.tables.textFields["Dress, T-Shirt, ..."].typeText("Sweater")
        app.navigationBars["Add"].buttons["Save"].tap()

        app.navigationBars["List"].buttons["plus.circle"].tap()
        app.tables.textFields["Dress, T-Shirt, ..."].tap()
        app.tables.textFields["Dress, T-Shirt, ..."].typeText("Shirt")
        app.navigationBars["Add"].buttons["Save"].tap()

        let alphaButton = app.buttons["Alpha"]
        alphaButton.tap()

        let createdButton = app.buttons["Creation Time"]
        createdButton.tap()
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
