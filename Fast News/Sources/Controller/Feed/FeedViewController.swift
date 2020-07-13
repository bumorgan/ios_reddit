//
//  FeedViewController.swift
//  Fast News
//
//  Copyright © 2019 Lucas Moreton. All rights reserved.
//

import Foundation
import UIKit

class FeedViewController: UIViewController {
    
    //MARK: - Constants
    
    let kToDetails: String = "toDetails"
    
    //MARK: - Properties
    
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
        navigationItem.title = "Fast News"
        fetchHotNews()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let hotNewsViewModel = sender as? HotNewsViewModel else { return }
        guard let detailViewController = segue.destination as? FeedDetailsViewController else { return }
        
        detailViewController.hotNewsViewModel = hotNewsViewModel
    }
    
    private func fetchHotNews(quantity: Int? = nil, after: String? = nil) {
        HotNewsProvider.shared.hotNews(quantity: quantity, after: after) { (completion) in
            do {
                let loadedHotNew = try completion()
                self.hotNews.append(contentsOf: loadedHotNew)
            } catch {
                // TODO: Implement error treatment
                print(error.localizedDescription)
            }
        }
    }
}

extension FeedViewController: FeedViewDelegate {
    func didTouch(indexPath: IndexPath) {
        self.performSegue(withIdentifier: kToDetails, sender: self.mainView.viewModels[indexPath.row])
    }
    
    func loadMore(afterHotNew hotNewFullName: String?) {
        fetchHotNews(after: hotNewFullName)
    }
}
