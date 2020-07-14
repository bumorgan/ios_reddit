//
//  RemoteToCacheMappers.swift
//  Fast News
//
//  Created by Bruno Morgan on 14/07/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation

extension HotNewsRM {
    func toCacheModel() -> HotNewsCM {
        return HotNewsCM(id: id,
                         title: title,
                         name: name,
                         previewUrl: preview?.images?.first?.source?.url?.htmlDecoded,
                         url: url,
                         created: created,
                         ups: ups,
                         downs: downs,
                         score: score,
                         authorFullname: authorFullname,
                         numComments: numComments)
    }
}
