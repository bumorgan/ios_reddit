//
//  FeedViewControllerTests.swift
//  Fast NewsTests
//
//  Created by Bruno Morgan on 15/07/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import XCTest
@testable import Fast_News

class FeedViewControllerTests: XCTestCase {
    var sut: FeedViewController!

    override func setUp() {
        super.setUp()
        sut = FeedViewController()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testHotNewsArrayIsEmptyWhenInitialized() {
        XCTAssert(sut.hotNews.isEmpty)
    }
}
