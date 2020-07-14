//
//  SourceRM.swift
//  Fast News
//
//  Copyright © 2019 Lucas Moreton. All rights reserved.
//

import Foundation

struct SourceRM: Codable {
    let url: String?
    
    private enum CodingKeys: String, CodingKey {
        case url
    }
}
