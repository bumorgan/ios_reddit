//
//  CacheDataSource.swift
//  Fast News
//
//  Created by Bruno Morgan on 13/07/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation

class CacheDataSource {
    private let cache = NSCache<NSString, NSArray>()
    private let hotNewKey = NSString("hotNew")
    
    func getHotNews() -> [HotNews]? {
        return cache.object(forKey: hotNewKey) as? [HotNews]
    }
    
    func upsertHotNews(hotNews: [HotNews]) {
        cache.setObject(hotNews as NSArray, forKey: hotNewKey)
    }
}
