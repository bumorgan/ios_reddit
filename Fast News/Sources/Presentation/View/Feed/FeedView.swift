//
//  FeedView.swift
//  Fast News
//
//  Copyright © 2019 Lucas Moreton. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol FeedViewDelegate {
    func didTouch(indexPath: IndexPath)
    func fetchHotNews()
    func share(indexPath: IndexPath)
}

class FeedView: FastNewsUIView {
    
    //MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModels: [HotNewsViewModel] = [HotNewsViewModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    var delegate: FeedViewDelegate?
    let activyIndicator = UIActivityIndicatorView(style: .gray)
    
    //MARK: - Public Methods
    
    func setup(with viewModels: [HotNewsViewModel], and delegate: FeedViewDelegate) {
        tableView.register(UINib(nibName: "FeedCell", bundle: Bundle.main), forCellReuseIdentifier: "FeedCell")
        
        self.delegate = delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        self.viewModels = viewModels
    }
}

extension FeedView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedCell else { fatalError("Cell is not of type FeedCell!") }
        
        cell.setup(hotNewsViewModel: viewModels[indexPath.row])
        cell.shareButton.rx.tap.bind { _ in
            self.delegate?.share(indexPath: indexPath)
        }.disposed(by: disposeBag)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _ = tableView.cellForRow(at: indexPath) as? FeedCell {
            delegate?.didTouch(indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        activyIndicator.startAnimating()
        return activyIndicator
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        delegate?.fetchHotNews()
    }
}
