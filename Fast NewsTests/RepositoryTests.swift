//
//  RepositoryTests.swift
//  Fast NewsTests
//
//  Created by Bruno Morgan on 15/07/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import XCTest
import RxSwift
@testable import Fast_News

class RepositoryTests: XCTestCase {
    var sut: Repository!
    var disposeBag: DisposeBag!
    let mockedRemoteDataSource = RemoteDataSourceMock()
    let mockedCacheDataSource = CacheDataSourceMock()

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        sut = Repository(remoteDataSource: mockedRemoteDataSource,
                         cacheDataSource: mockedCacheDataSource)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testHotNewsFromRemote() {
        //given
        mockedRemoteDataSource.internetOn()
        
        //when
        sut.getHotNews(isFirstPage: true).subscribe() { event in
            switch event {
                case .success(let loadedHotNews):
                    //then
                    XCTAssert(loadedHotNews.first?.title == "Remote")
                case .error:
                    XCTFail()
            }
        }.disposed(by: disposeBag)
    }
    
    func testHotNewsFromCache() {
        //given
        mockedRemoteDataSource.internetOff()
        
        //when
        sut.getHotNews(isFirstPage: true).subscribe() { event in
            switch event {
                case .success(let loadedHotNews):
                    //then
                    XCTAssert(loadedHotNews.first?.title == "Cache")
                case .error:
                    XCTFail()
            }
        }.disposed(by: disposeBag)
    }
}
