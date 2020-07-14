//
//  CacheToDomainMappers.swift
//  Fast News
//
//  Created by Bruno Morgan on 14/07/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation

extension HotNewsCM {
    func toDomainModel() -> HotNews {
        return HotNews(id: id,
                         title: title,
                         name: name,
                         previewUrl: previewUrl,
                         url: url,
                         created: created,
                         ups: ups,
                         downs: downs,
                         score: score,
                         authorFullname: authorFullname,
                         numComments: numComments)
    }
}
