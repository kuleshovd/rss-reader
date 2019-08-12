//
//  ColorsManager.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 11/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import Foundation
import UIKit

class ColorsManager {
    
    // In case of custom color scheme UIColor extension may be implemented
    class func setupColors() {
        UITabBar.appearance().tintColor = .darkGray
        UINavigationBar.appearance().tintColor = .darkGray
        UITableView.appearance().tintColor = .darkGray
    }
}
