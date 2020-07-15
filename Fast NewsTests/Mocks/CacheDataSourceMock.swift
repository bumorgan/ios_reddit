//
//  CacheDataSourceMock.swift
//  Fast NewsTests
//
//  Created by Bruno Morgan on 15/07/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation
import RxSwift
@testable import Fast_News

class CacheDataSourceMock: CacheDataSource {
    private let cmHotNews = [HotNewsCM(id: "1",
                                       title: "Cache",
                                       name: nil,
                                       previewUrl: nil,
                                       url: nil,
                                       created: nil,
                                       ups: nil,
                                       downs: nil,
                                       score: nil,
                                       authorFullname: nil,
                                       numComments: nil)]
    
    override func getHotNews() -> Single<[HotNewsCM]?> {
        return Single.just(cmHotNews)
    }
}
