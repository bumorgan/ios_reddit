//
//  FeedViewController.swift
//  Fast News
//
//  Copyright © 2019 Lucas Moreton. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class FeedViewController: FastNewsUIViewController {
    //MARK: - Constants
    
    let kToDetails: String = "toDetails"
    
    //MARK: - Properties
    
    let repository = Repository(remoteDataSource: RemoteDataSource(),
                                cacheDataSource: CacheDataSource())
    
    var hotNews: [HotNews] = [HotNews]() {
        didSet {
            let viewModels = hotNews.map { (news) in
                HotNewsViewModel(hotNews: news)
            }
            self.mainView.setup(with: viewModels, and: self)
        }
    }
    
    var mainView: FeedView {
        guard let view = self.view as? FeedView else {
            fatalError("View is not of type FeedView!")
        }
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "feedView"
        navigationItem.title = "Fast News"
        fetchHotNews(isFirstPage: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let hotNewsViewModel = sender as? HotNewsViewModel else { return }
        guard let detailViewController = segue.destination as? FeedDetailsViewController else { return }
        
        detailViewController.hotNewsViewModel = hotNewsViewModel
    }
    
    private func fetchHotNews(isFirstPage: Bool) {
        if (isFirstPage) {
            self.displayLoading()
        }
        repository.getHotNews(isFirstPage: isFirstPage).subscribe() { event in
            switch event {
                case .success(let loadedHotNews):
                    self.removeLoading()
                    self.hotNews.append(contentsOf: loadedHotNews)
                case .error(let error):
                    print("Error: ", error)
            }
        }.disposed(by: disposeBag)
    }
}

extension FeedViewController: FeedViewDelegate {
    func share(indexPath: IndexPath) {
        let viewModel = self.mainView.viewModels[indexPath.row]
        if let url = NSURL(string: viewModel.url) {
            let vc = UIActivityViewController(activityItems: [viewModel.title, url], applicationActivities: nil)
            present(vc, animated: true)
        }
    }
    
    func didTouch(indexPath: IndexPath) {
        self.performSegue(withIdentifier: kToDetails, sender: self.mainView.viewModels[indexPath.row])
    }
    
    func fetchMoreHotNews() {
        self.fetchHotNews(isFirstPage: false)
    }
}
