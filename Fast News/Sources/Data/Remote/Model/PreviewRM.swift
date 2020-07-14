//
//  PreviewRM.swift
//  Fast News
//
//  Copyright © 2019 Lucas Moreton. All rights reserved.
//

import Foundation

struct PreviewRM: Codable {
    let images: [ImageRM]?
    
    private enum CodingKeys: String, CodingKey {
        case images
    }
}
