//
//  HotNewsProvider.swift
//  Fast News
//
//  Copyright © 2019 Lucas Moreton. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class HotNewsProvider {
    
    //MARK: - Constants
    
    // Hot News endpoint
    private let kHotNewsEndpoint = "/r/ios/hot/.json"
    // Comments endpoint
    private let kCommentsEndpoint = "/r/ios/comments/@.json"
    
    // Hot News key/value parameters
    private let kLimitKey = "limit"
    private let kLimitValue = 5
    private let kAfterKey = "after"
    private var kAfterValue = ""
    
    //MARK: - Singleton
    
    static let shared: HotNewsProvider = HotNewsProvider()
    
    //MARK: - Public Methods
    
    func hotNews() -> Single<[HotNews]> {
        return Single<[HotNews]>.create { (single) -> Disposable in
            let alamofire = APIProvider.shared.sessionManager
            let requestString = APIProvider.shared.baseURL() + self.kHotNewsEndpoint
            
            let parameters: Parameters = [ self.kLimitKey : self.kLimitValue,
                                           self.kAfterKey : self.kAfterValue ]
            
            do {
                let requestURL = try requestString.asURL()
                       
                let headers: HTTPHeaders = APIProvider.shared.baseHeader()
            
                alamofire.request(requestURL, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: headers).responseJSON { (response) in
                        
                        switch response.result {
                        case .success:
                            
                            guard let hotNewsDict = response.result.value as? [String: AnyObject],
                                  let dictArray = hotNewsDict["data"]?["children"] as? [[String: AnyObject]] else {
                                single(.success([HotNews]()))
                                return
                            }
                            
                            var hotNewsArray: [HotNews] = [HotNews]()
                            
                            for hotNews in dictArray {
                                let data = hotNews["data"]
                                
                                guard let jsonData = try? JSONSerialization.data(withJSONObject: data as Any, options: .prettyPrinted),
                                      let hotNews = try? JSONDecoder().decode(HotNews.self, from: jsonData) else {
                                    single(.success([HotNews]()))
                                    return
                                }
                                
                                hotNewsArray.append(hotNews)
                            }
                            
                            if let after = hotNewsDict["data"]?["after"] as? String {
                                self.kAfterValue = after
                            }
                            
                            single(.success(hotNewsArray))
                            break
                        case .failure(let error):
                            single(.error(error))
                            break
                        }
                    }
            } catch {
                single(.error(error))
            }
            return Disposables.create()
        }
    }
    
    func hotNewsComments(id: String) -> Single<[Comment]> {
        return Single<[Comment]>.create { (single) -> Disposable in
            let alamofire = APIProvider.shared.sessionManager
            let endpoint = self.kCommentsEndpoint.replacingOccurrences(of: "@", with: id)
            let requestString = APIProvider.shared.baseURL() + endpoint
            
            do {
                let requestURL = try requestString.asURL()
                
                let headers: HTTPHeaders = APIProvider.shared.baseHeader()
                
                alamofire.request(requestURL, method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: headers).responseJSON { (response) in
                    
                    switch response.result {
                    case .success:
                        
                        guard let hotNewsDict = response.result.value as? [[String: AnyObject]],
                            let dictArray = hotNewsDict.last?["data"]?["children"] as? [[String: AnyObject]] else {
                                single(.success([Comment]()))
                                return
                        }
                        
                        var commentsArray: [Comment] = [Comment]()
                        
                        for comment in dictArray {
                            let data = comment["data"]
                            
                            guard let jsonData = try? JSONSerialization.data(withJSONObject: data as Any, options: .prettyPrinted),
                                let comment = try? JSONDecoder().decode(Comment.self, from: jsonData) else {
                                    single(.success([Comment]()))
                                    return
                            }
                            
                            if !comment.isEmpty() {
                                commentsArray.append(comment)
                            }
                        }
                        
                        single(.success(commentsArray))
                        break
                    case .failure(let error):
                        single(.error(error))
                        break
                    }
                }
            } catch {
                single(.error(error))
            }
            return Disposables.create()
        }
    }
}
