//
//  RxSwift+Ext.swift
//  Fast News
//
//  Created by Bruno Morgan on 14/07/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import RxSwift
import RxCocoa
import Foundation

extension PrimitiveSequence where PrimitiveSequence.Element == Never, PrimitiveSequence.Trait == RxSwift.CompletableTrait {
    public static func fromAction(action: @escaping () throws -> Void) -> RxSwift.Completable {
        return Completable.empty().do(onCompleted: action)
    }
}
