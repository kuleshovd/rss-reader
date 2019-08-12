//
//  Feed.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 11/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import Foundation
import FeedKit

class Feed {
    let name: String?
    let imageURL: URL?
    
    let articles: [Article]?
    
    init(rssFeed: RSSFeed) {
        name = rssFeed.title
        if let urlString = rssFeed.image?.url {
            imageURL = URL(string: urlString)
        } else {
            imageURL = nil
        }
        articles = rssFeed.items?.map { Article(feedItem: $0) }
    }
}
