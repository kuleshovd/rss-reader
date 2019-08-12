//
//  Alert.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 11/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import UIKit

class Alert {
    
    class func showInfoAlert(on viewController: UIViewController, title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel))
        viewController.present(alertVC, animated: true)
    }
    
    class func showErrorAlert(on viewController: UIViewController, message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel))
        viewController.present(alertVC, animated: true)
    }
}
