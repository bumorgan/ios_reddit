//
//  FeedDetailsViewController.swift
//  Fast News
//
//  Copyright © 2019 Lucas Moreton. All rights reserved.
//

import UIKit

class FeedDetailsViewController: FastNewsUIViewController {
    
    //MARK: - Properties
    let repository = Repository(remoteDataSource: RemoteDataSource(),
                                cacheDataSource: CacheDataSource())
    
    var hotNewsViewModel: HotNewsViewModel?
    
    var comments: [Comment] = [Comment]() {
        didSet {
            var viewModels: [TypeProtocol] = [TypeProtocol]()
            
            if let hotNews = hotNewsViewModel {
                viewModels.append(hotNews)
            }
            
            _ = comments.map { (comment) in
                viewModels.append(CommentViewModel(comment: comment))
            }
            
            self.mainView.setup(with: viewModels, and: self)
        }
    }
    
    var mainView: FeedDetailsView {
        guard let view = self.view as? FeedDetailsView else {
            fatalError("View is not of type FeedDetailsView!")
        }
        return view
    }
    
    private func setupObservables() {
        self.onTryAgainPressed.bind {
            self.fetchComments()
        }.disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        setupObservables()
        fetchComments()
    }
    
    private func fetchComments() {
        self.displayLoading()
        repository.getComments(id: hotNewsViewModel?.id ?? "").subscribe() { event in
            switch event {
                case .success(let comments):
                    self.removeLoading()
                    self.comments = comments
                case .error:
                    self.removeLoading()
                    self.displayErrorDialog()
            }
        }.disposed(by: disposeBag)
    }
}

extension FeedDetailsViewController: FeedDetailsViewDelegate {
    func share(indexPath: IndexPath) {
        guard self.mainView.viewModels[indexPath.row].type == .hotNews,
            let viewModel = self.mainView.viewModels[indexPath.row] as? HotNewsViewModel else { return }
        
        if let url = NSURL(string: viewModel.url) {
            let vc = UIActivityViewController(activityItems: [viewModel.title, url], applicationActivities: nil)
            present(vc, animated: true)
        }
    }
    
    func didTouch(indexPath: IndexPath) {
        guard self.mainView.viewModels[indexPath.row].type == .hotNews,
            let viewModel = self.mainView.viewModels[indexPath.row] as? HotNewsViewModel else { return }
        
        if let url = URL(string: viewModel.url) {
            UIApplication.shared.open(url)
        }
    }
}
