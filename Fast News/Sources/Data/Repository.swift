//
//  Repository.swift
//  Fast News
//
//  Created by Bruno Morgan on 14/07/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation
import RxSwift

class Repository {
    let remoteDataSource = RemoteDataSource()
    let cacheDataSource = CacheDataSource()
    
    func getHotNews() -> Single<[HotNews]> {
        return remoteDataSource.getHotNews()
            .flatMap { rmHotNews in
                let cmHotNews = rmHotNews.map{ $0.toCacheModel() }
                return self.cacheDataSource.upsertHotNews(hotNews: cmHotNews).andThen(Single.just(cmHotNews))
            }.catchError { error in self.cacheDataSource.getHotNews()
                .map { (cmHotNews: [HotNewsCM]?) -> [HotNewsCM] in
                    guard let hotNews = cmHotNews else { throw error }
                    return hotNews
                }
            }.map { $0.map{ $0.toDomainModel() } }
    }
    
    func getComments(id: String) -> Single<[Comment]> {
        return remoteDataSource.getComments(id: id).map { $0.map { $0.toDomainModel() } }
    }
}
