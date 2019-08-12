//
//  ArticleDataObject.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 11/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import Foundation

class ArticleDataObject {
    let title: String
    let descriptionText: String
    let imageURL: URL?
    
    init(article: Article) {
        title = article.title ?? "Default title"
        descriptionText = article.descriptionText?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "Default description"
        imageURL = article.imageURL
    }
}
