//
//  XCUIApplication+Extensions.swift
//  Fast NewsUITests
//
//  Created by Bruno Morgan on 14/07/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import XCTest

extension XCUIApplication {
    var isDisplayingFeed: Bool {
        return otherElements["feedView"].exists
    }
}
