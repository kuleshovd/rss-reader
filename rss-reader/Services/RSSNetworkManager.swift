//
//  FeedNetworkManager.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 10/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import Foundation
import FeedKit

enum NetworkError: String {
    case fetchError = "Error while fetching feed"
    
    func description() -> String {
        return self.rawValue
    }
}

class RSSNetworkManager: NetworkManager {
    
    func fetchFeedFrom(sourceURL: URL, completion: @escaping (Feed?, NetworkError?) -> ()) {
        FeedParser(URL: sourceURL).parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { (result) in
            DispatchQueue.main.async {
                if let rssFeed = result.rssFeed {
                    completion(Feed(rssFeed: rssFeed), nil)
                } else {
                    completion(nil, .fetchError)
                }
            }
        }
    }
}
