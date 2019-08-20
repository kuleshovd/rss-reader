//
//  Source manager protocols.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 10/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import Foundation

// basic manager protocols

protocol SourceRemoving {
    func removeSourceWith(dataObject: SourceDataObject)
}

protocol SourceUpdating {
    func updateSourceWith(dataObject: SourceDataObject, shouldValidate: Bool, completion: @escaping (NetworkError?) -> ())
}

protocol SourceAdding {
    func addSourceWith(dataObject: SourceDataObject, completion: @escaping (NetworkError?) -> ())
}

protocol SourceRetrieving {
    func getSourceDataObjects() -> [SourceDataObject]
}

protocol FeedRetrieving {
    func getFeedDataObjects() -> [FeedDataObject]
}

protocol FeedUpdatable {
    func updateFeed(completion: @escaping (NetworkError?) -> ())
}


typealias SourceManager =   SourceAdding &
                            SourceRemoving &
                            SourceUpdating &
                            SourceRetrieving &
                            FeedRetrieving &
                            FeedUpdatable


// internal managers

protocol StorageManager {
    func remove(source: Source)
    func getSources() -> [Source]
    func update(source: Source)
    func add(source: Source)
}

protocol NetworkManager {
    func fetchFeedFrom(sourceURL: URL, completion: @escaping (Feed?, NetworkError?) -> ())
}
