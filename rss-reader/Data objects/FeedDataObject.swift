//
//  FeedDataObject.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 11/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import Foundation

class FeedDataObject {
    
    private(set) var identifier: String?
    let name: String
    let imageURL: URL?
    let articles: [ArticleDataObject]
    
    init(source: Source) {
        identifier = source.identifier
        self.name = source.name
        self.imageURL = source.feed?.imageURL
        self.articles = (source.feed?.articles ?? []).map { ArticleDataObject(article: $0) }
    }
}
