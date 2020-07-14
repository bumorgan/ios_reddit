//
//  FastNewsUIViewController.swift
//  Fast News
//
//  Created by Bruno Morgan on 14/07/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class FastNewsUIViewController: UIViewController {
    
    //MARK: - Properties
    
    let disposeBag = DisposeBag()
    var loading: UIView?
    
    func displayLoading() {
        let loadingView = UIView.init(frame: self.view.bounds)
        loadingView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView.init(style: .whiteLarge)
        activityIndicator.startAnimating()
        activityIndicator.center = loadingView.center
        
        DispatchQueue.main.async {
            loadingView.addSubview(activityIndicator)
            self.view.addSubview(loadingView)
        }
        
        loading = loadingView
    }
    
    func removeLoading() {
        DispatchQueue.main.async {
            self.loading?.removeFromSuperview()
            self.loading = nil
        }
    }
}
