//
//  ArticleViewModel.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 10/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import Foundation

class ArticleViewModel {
    
    let articleDataObject: ArticleDataObject
    
    init(dataObject: ArticleDataObject) {
        articleDataObject = dataObject
    }
    
    func title() -> String {
        return articleDataObject.title
    }
    
    func description() -> String {
        return articleDataObject.descriptionText
    }
    
    func imageURL() -> URL? {
        return articleDataObject.imageURL
    }
}
