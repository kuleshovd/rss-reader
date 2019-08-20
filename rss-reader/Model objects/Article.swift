//
//  Article.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 11/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import Foundation
import FeedKit

class Article {
    let title: String?
    let descriptionText: String?
    let imageURL: URL? = nil
    
    init(feedItem: RSSFeedItem) {
        title = feedItem.title
        descriptionText = feedItem.description
        //TODO: Find way to get image from article
    }
}
