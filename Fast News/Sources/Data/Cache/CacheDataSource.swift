//
//  CacheDataSource.swift
//  Fast News
//
//  Created by Bruno Morgan on 13/07/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyUserDefaults

class CacheDataSource {
    private let hotNewsKey = DefaultsKey<[HotNewsCM]?>("hotNewsKey")
    
    func upsertHotNews(hotNews: [HotNewsCM], resetCache: Bool) -> Completable {
        return Completable.fromAction {
            if resetCache {
                Defaults[key: self.hotNewsKey] = hotNews
            } else {
                Defaults[key: self.hotNewsKey]?.append(contentsOf: hotNews)
            }
        }
    }

    func getHotNews() -> Single<[HotNewsCM]?> {
        return Observable.create({ (emitter: AnyObserver<[HotNewsCM]?>) -> Disposable in
            emitter.onNext(Defaults[key: self.hotNewsKey])
            return Disposables.create()
        }).take(1).asSingle()
    }
}
