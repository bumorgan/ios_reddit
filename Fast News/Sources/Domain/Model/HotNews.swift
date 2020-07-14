//
//  HotNews.swift
//  Fast News
//
//  Created by Bruno Morgan on 14/07/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation

struct HotNews {
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
    
    init(id: String?, title: String?, name: String?, previewUrl: String?, url: String?, created: Int?, ups: Int?, downs: Int?, score: Int?, authorFullname: String?, numComments: Int?) {
        self.id = id
        self.title = title
        self.name = name
        self.previewUrl = previewUrl
        self.url = url
        self.created = created
        self.ups = ups
        self.downs = downs
        self.score = score
        self.authorFullname = authorFullname
        self.numComments = numComments
    }
}
