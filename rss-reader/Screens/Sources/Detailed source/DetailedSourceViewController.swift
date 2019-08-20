//
//  DetailedSourceViewController.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 10/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import UIKit
import SVProgressHUD

class DetailedSourceViewController: UIViewController {
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var urlTextField: UITextField!
    
    var viewModel: DetailedSourceViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = viewModel.getName()
        urlTextField.text = viewModel.getURLString()
    }
    
    
    //MARK: actions
  
    @IBAction func didTapDoneButton(_ sender: Any) {
        SVProgressHUD.show()
        viewModel.validate(name: nameTextField.text, URLString: urlTextField.text) { (errorString) in
            if let errorString = errorString {
                SVProgressHUD.showError(withStatus: errorString)
            } else {
                SVProgressHUD.showSuccess(withStatus: nil)
                self.viewModel.finish()
            }
        }
    }
    
}
