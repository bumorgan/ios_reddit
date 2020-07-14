//
//  FeedDetailsView.swift
//  Fast News
//
//  Copyright © 2019 Lucas Moreton. All rights reserved.
//

import UIKit

protocol FeedDetailsViewDelegate {
    func didTouch(indexPath: IndexPath)
    func share(indexPath: IndexPath)
}

class FeedDetailsView: DisposableUIView {
    
    //MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    var viewModels: [TypeProtocol] = [TypeProtocol]() {
        didSet {
            tableView.reloadData()
        }
    }
    var delegate: FeedDetailsViewDelegate?
    
    //MARK: - Public Methods
    
    func setup(with viewModels: [TypeProtocol], and delegate: FeedDetailsViewDelegate) {
        tableView.estimatedRowHeight = 400
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: "FeedCell", bundle: Bundle.main), forCellReuseIdentifier: "FeedCell")
        tableView.register(UINib(nibName: "CommentCell", bundle: Bundle.main), forCellReuseIdentifier: "CommentCell")
        
        self.delegate = delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        self.viewModels = viewModels
    }
}

extension FeedDetailsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.row]
        
        switch viewModel.type {
        case .hotNews:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedCell else { fatalError("Cell is not of type FeedCell!") }
            
            cell.setup(viewModel: viewModel)
            cell.shareButton.rx.tap.bind { _ in
                self.delegate?.share(indexPath: indexPath)
            }.disposed(by: disposeBag)
            
            return cell
        case .comment:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as? CommentCell else { fatalError("Cell is not of type CommentCell!") }
            
            cell.setup(viewModel: viewModel)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModels[indexPath.row].type {
        case .hotNews:
            return 400.0
        default:
            return 100.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = viewModels[indexPath.row]
        
        switch viewModel.type {
        case .hotNews:
            guard let _ = tableView.cellForRow(at: indexPath) as? FeedCell else { fatalError("Cell is not of type FeedCell!") }
            
            delegate?.didTouch(indexPath: indexPath)
        case .comment:
            return
        }
    }
}
