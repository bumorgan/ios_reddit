//
//  HotNewsRM.swift
//  Fast News
//
//  Copyright © 2019 Lucas Moreton. All rights reserved.
//

import Foundation

struct HotNewsRM: Codable {
    let id: String?
    let title: String?
    let name: String?
    let preview: PreviewRM?
    let url: String?
    let created: Int?
    let ups: Int?
    let downs: Int?
    let score: Int?
    let authorFullname: String?
    let numComments: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id, title, preview, url, created, ups, downs, score, name
        case authorFullname = "author_fullname"
        case numComments = "num_comments"
    }
}
