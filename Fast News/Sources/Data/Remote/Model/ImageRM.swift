//
//  ImageRM.swift
//  Fast News
//
//  Copyright © 2019 Lucas Moreton. All rights reserved.
//

import Foundation

struct ImageRM: Codable {
    let source: SourceRM?
    
    private enum CodingKeys: String, CodingKey {
        case source
    }
}
