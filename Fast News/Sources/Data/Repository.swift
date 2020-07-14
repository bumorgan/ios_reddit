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
    
    func getHotNews() -> Single<[HotNews]> {
        return remoteDataSource.getHotNews().catchError({ _ in
            Single.just([HotNews]())
        })
    }
    
    func getComments(id: String) -> Single<[Comment]> {
        return remoteDataSource.getComments(id: id)
    }
}
