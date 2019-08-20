//
//  SourceListFlowCoordinator.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 10/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import UIKit

class SourceListFlowCoordinator: Coordinator {
    
    private let sourceListNavigationController: UINavigationController
    
    private let sourceStoryboardName = "SourceStoryboard"
    private let sourceListViewControllerIdentifier = "sourceListViewController"
    private let detailedSourceViewControllerIdentifier = "detailedSourceViewController"
    
    private let sourceManager: SourceManager
    
    init(sourceManager: SourceManager) {
        self.sourceManager = sourceManager
        
        let sourceListViewController = UIStoryboard(name: sourceStoryboardName, bundle: nil).instantiateViewController(withIdentifier: sourceListViewControllerIdentifier) as! SourceListViewController
        sourceListNavigationController = UINavigationController(rootViewController: sourceListViewController)
        
        let sourceListViewModel = SourceListViewModel(sourceManager: sourceManager)
        sourceListViewModel.coordinationDelegate = self
        sourceListViewController.viewModel = sourceListViewModel
        
    }
    
    var rootViewController: UIViewController {
        return sourceListNavigationController
    }
    
    func finished() {
        sourceListNavigationController.popViewController(animated: true)
    }
    
}

extension SourceListFlowCoordinator: SourceListViewModelDelegate {
    func openChangeSourceWith(changeDataObject: SourceDataObject) {
        let detailedSourceViewController = UIStoryboard(name: sourceStoryboardName, bundle: nil).instantiateViewController(withIdentifier: detailedSourceViewControllerIdentifier) as! DetailedSourceViewController
        let changeSourceViewModel = ChangeSourceViewModel(sourceManager: sourceManager, changeDataObject: changeDataObject)
        changeSourceViewModel.coordinationDelegate = self
        detailedSourceViewController.viewModel = changeSourceViewModel
        
        sourceListNavigationController.pushViewController(detailedSourceViewController, animated: true)
    }
    
    func openAddSource() {
        let detailedSourceViewController = UIStoryboard(name: sourceStoryboardName, bundle: nil).instantiateViewController(withIdentifier: detailedSourceViewControllerIdentifier) as! DetailedSourceViewController
        let addSourceViewModel = AddSourceViewModel(sourceManager: sourceManager)
        addSourceViewModel.coordinationDelegate = self
        detailedSourceViewController.viewModel = addSourceViewModel
        
        sourceListNavigationController.pushViewController(detailedSourceViewController, animated: true)
    }
}
