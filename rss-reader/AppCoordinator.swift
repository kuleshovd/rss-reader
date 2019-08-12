//
//  AppCoordinator.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 10/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
  
    private let tabBarController: UITabBarController
    
    private let sourceListCoordinator: SourceListFlowCoordinator
    private let feedCoordinator: FeedFlowCoordinator
    
    private let sourceManager: SourceManager
    
    init() {
        
        //setup services
        let storageManager = UserDefaultsStorageManager()
        let networkManager = RSSNetworkManager()
        
        sourceManager = RSSSourceManager(storageManager: storageManager, networkManager: networkManager)
        
        
        //setup flow
        sourceListCoordinator = SourceListFlowCoordinator(sourceManager: sourceManager)
        feedCoordinator = FeedFlowCoordinator(sourceManager: sourceManager)
        
        tabBarController = UITabBarController()
        tabBarController.viewControllers = [feedCoordinator.rootViewController,
                                            sourceListCoordinator.rootViewController]
    }
    
    var rootViewController: UIViewController {
        return tabBarController
    }
    
    func finished() {
        fatalError("App Coordinator can't finish root flows")
    }
}
