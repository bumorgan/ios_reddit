//
//  HotNewsCM.swift
//  Fast News
//
//  Created by Bruno Morgan on 14/07/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

struct HotNewsCM: Codable, DefaultsSerializable {
    let id: String?
    let title: String?
    let name: String?
    let previewUrl: String?
    let url: String?
    let created: Int?
    let ups: Int?
    let downs: Int?
    let score: Int?
    let authorFullname: String?
    let numComments: Int?
}
