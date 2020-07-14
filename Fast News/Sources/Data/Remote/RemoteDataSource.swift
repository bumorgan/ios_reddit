//
//  RemoteDataSource.swift
//  Fast News
//
//  Created by Bruno Morgan on 14/07/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation
import RxSwift

class RemoteDataSource {
    let provider = HotNewsProvider()
    
    func getHotNews() -> Single<[HotNews]> {
        return provider.hotNews()
    }
    
    func getComments(id: String) -> Single<[Comment]> {
        return provider.hotNewsComments(id: id)
    }
}
