//
//  ArticleCell.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 10/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleCell: UITableViewCell {

    @IBOutlet private weak var articleImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    func setAppearance(viewModel: ArticleCellViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.descriptiontext
        articleImageView.kf.setImage(with: viewModel.imageURL, placeholder: UIImage(named: "article_placeholder")!)
    }

}
