//
//  OnboardingUITests.swift
//  Fast NewsUITests
//
//  Created by Bruno Morgan on 14/07/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import XCTest

class OnboardingUITests: XCTestCase {
    var app: XCUIApplication!

    // MARK: - XCTestCase
    
    override func setUp() {
        super.setUp()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
    }
    
    // MARK: - Tests

    func testIfFeedViewDidLoad() {
        app.launch()

        XCTAssertTrue(app.isDisplayingFeed)
    }

}
