//
//  UIViewController+Ext.swift
//  Fast News
//
//  Created by Bruno Morgan on 14/07/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation
import UIKit

var loading: UIView?

extension UIViewController {
    func displayLoading(onView : UIView) {
        let loadingView = UIView.init(frame: onView.bounds)
        loadingView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = loadingView.center
        
        DispatchQueue.main.async {
            loadingView.addSubview(ai)
            onView.addSubview(loadingView)
        }
        
        loading = loadingView
    }
    
    func removeLoading() {
        DispatchQueue.main.async {
            loading?.removeFromSuperview()
            loading = nil
        }
    }
}
