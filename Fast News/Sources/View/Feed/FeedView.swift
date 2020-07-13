//
//  FeedView.swift
//  Fast News
//
//  Copyright © 2019 Lucas Moreton. All rights reserved.
//

import UIKit

protocol FeedViewDelegate {
    func didTouch(indexPath: IndexPath)
    func loadMore(afterHotNew: String?)
}

class FeedView: UIView {
    
    //MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    var viewModels: [HotNewsViewModel] = [HotNewsViewModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    var delegate: FeedViewDelegate?
    
    //MARK: - Public Methods
    
    func setup(with viewModels: [HotNewsViewModel], and delegate: FeedViewDelegate) {
        tableView.register(UINib(nibName: "FeedCell", bundle: Bundle.main), forCellReuseIdentifier: "FeedCell")
        tableView.register(UINib(nibName: "FeedLoadMoreCell", bundle: Bundle.main), forCellReuseIdentifier: "FeedLoadMoreCell")
        
        self.delegate = delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        self.viewModels = viewModels
    }
}

extension FeedView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count + 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tableViewCell: UITableViewCell!
        if (indexPath.row >= viewModels.count) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedLoadMoreCell", for: indexPath) as? FeedLoadMoreCell {
                tableViewCell = cell
            } else { fatalError("Cell is not of type FeedLoadMoreCell!") }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedCell {
                tableViewCell = cell
                cell.setup(hotNewsViewModel: viewModels[indexPath.row])
            } else { fatalError("Cell is not of type FeedCell!") }
                
        }
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row >= viewModels.count) {
            return 50.0
        }
        return 260.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _ = tableView.cellForRow(at: indexPath) as? FeedCell {
            delegate?.didTouch(indexPath: indexPath)
        }
        
        if let _ = tableView.cellForRow(at: indexPath) as? FeedLoadMoreCell {
            delegate?.loadMore(afterHotNew: viewModels.last?.name)
        }
        
    }
}
