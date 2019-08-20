//
//  FeedFlowCoordinator.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 10/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import UIKit

class FeedFlowCoordinator: Coordinator {
    
    private let feedNavigationController: UINavigationController
    
    private let feedStoryboardName = "FeedStoryboard"
    private let feedListViewControllerIdentifier = "feedListViewController"
    private let articleViewControllerIdentifier = "articleViewController"
    
    private let sourceManager: SourceManager
    
    init(sourceManager: SourceManager) {
        self.sourceManager = sourceManager
        
        let feedListViewController = UIStoryboard(name: feedStoryboardName, bundle: nil).instantiateViewController(withIdentifier: feedListViewControllerIdentifier) as! FeedListViewController
        feedNavigationController = UINavigationController(rootViewController: feedListViewController)
        
        let feedListViewModel = FeedListViewModel(sourceManager: sourceManager)
        feedListViewModel.coordinationDelegate = self
        feedListViewController.viewModel = feedListViewModel
        
    }
    
    var rootViewController: UIViewController {
        return feedNavigationController
    }
    
    func finished() {
        feedNavigationController.popViewController(animated: true)
    }
}

extension FeedFlowCoordinator: FeedListViewModelDelegate {
    func openArticleWith(dataObject: ArticleDataObject) {
        let articleViewController = UIStoryboard(name: feedStoryboardName, bundle: nil).instantiateViewController(withIdentifier: articleViewControllerIdentifier) as! ArticleViewController

        let articleViewModel = ArticleViewModel(dataObject: dataObject)
        articleViewController.viewModel = articleViewModel
        
        feedNavigationController.pushViewController(articleViewController, animated: true)
    }
}
