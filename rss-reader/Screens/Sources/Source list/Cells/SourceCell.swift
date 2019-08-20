//
//  SourceCell.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 10/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import UIKit

class SourceCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    
    func setAppearance(sourceName: String) {
        nameLabel.text = sourceName
    }

}
