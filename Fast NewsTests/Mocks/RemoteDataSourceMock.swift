//
//  RemoteDataSourceMock.swift
//  Fast NewsTests
//
//  Created by Bruno Morgan on 15/07/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation
import RxSwift
@testable import Fast_News

class RemoteDataSourceMock: RemoteDataSource {
    private let rmHotNews = [HotNewsRM(id: "1",
                                       title: "Remote",
                                       name: nil,
                                       preview: nil,
                                       url: nil,
                                       created: nil,
                                       ups: nil,
                                       downs: nil,
                                       score: nil,
                                       authorFullname: nil,
                                       numComments: nil)]
    
    private var internetConnection = true
    
    func internetOn() { internetConnection = true }
    
    func internetOff() { internetConnection = false }
    
    override func getHotNews() -> Single<[HotNewsRM]> {
        if internetConnection {
            return Single.just(rmHotNews)
        } else {
            return Single.error(MockedError.noInternetConnection)
        }
    }
}

enum MockedError: Error {
    case noInternetConnection
}
