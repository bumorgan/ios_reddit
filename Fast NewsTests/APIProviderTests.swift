//
//  APIProviderTests.swift
//  Fast NewsTests
//
//  Created by Bruno Morgan on 14/07/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import XCTest
@testable import Fast_News

class APIProviderTests: XCTestCase {
    
    func testIfAPIProviderIsReturningBaseUrl() {
        XCTAssert(APIProvider.shared.baseURL() == "https://www.reddit.com")
    }

}
