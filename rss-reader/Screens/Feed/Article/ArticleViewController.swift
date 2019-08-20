//
//  ArticleViewController.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 10/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var viewModel: ArticleViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = viewModel.title()
        descriptionTextView.text = viewModel.description()
        pictureImageView.kf.setImage(with: viewModel.imageURL(), placeholder: UIImage(named: "article_placeholder")!)
    }
   

}
