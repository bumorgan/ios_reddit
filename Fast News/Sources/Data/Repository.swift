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
    //MARK: - Properties
    private let remoteDataSource = RemoteDataSource()
    private let cacheDataSource = CacheDataSource()
    
    func getHotNews(isFirstPage: Bool) -> Single<[HotNews]> {
        return remoteDataSource.getHotNews()
            .flatMap { rmHotNews in
                let cmHotNews = rmHotNews.map{ $0.toCacheModel() }
                return self.cacheDataSource.upsertHotNews(hotNews: cmHotNews, resetCache: isFirstPage).andThen(Single.just(cmHotNews))
            }.catchError { error in self.cacheDataSource.getHotNews()
                .map { (cmHotNews: [HotNewsCM]?) -> [HotNewsCM] in
                    if let hotNews = cmHotNews, isFirstPage {
                        return hotNews
                    } else {
                        throw error
                    }
                }
            }.map { $0.map{ $0.toDomainModel() } }
    }
    
    func getComments(id: String) -> Single<[Comment]> {
        return remoteDataSource.getComments(id: id).map { $0.map { $0.toDomainModel() } }
    }
}
