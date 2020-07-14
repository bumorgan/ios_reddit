//
//  RemoteToDomainMappers.swift
//  Fast News
//
//  Created by Bruno Morgan on 14/07/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation

extension CommentRM {
    func toDomainModel() -> Comment {
        return Comment(created: created, ups: ups, downs: downs, body: body, authorFullname: authorFullname)
    }
}
