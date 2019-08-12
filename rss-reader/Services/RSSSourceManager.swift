//
//  RSSSourceManager.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 10/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import Foundation

class RSSSourceManager: SourceManager {
   
    private let storageManager: StorageManager
    private let networkManager: NetworkManager
    
    private var sources: [Source]
    
    init(storageManager: StorageManager, networkManager: NetworkManager) {
        self.storageManager = storageManager
        self.networkManager = networkManager
        
        sources = storageManager.getSources()
    }
    
    func getSourceDataObjects() -> [SourceDataObject] {
        return sources.map { SourceDataObject(source: $0) }
    }
    
    func getFeedDataObjects() -> [FeedDataObject] {
        return sources.map { FeedDataObject(source: $0) }
    }
    
    func updateSourceWith(dataObject: SourceDataObject, shouldValidate: Bool, completion: @escaping (NetworkError?) -> ()) {
        if let id = dataObject.identifier, let source = sourceWith(id: id) {
            if !shouldValidate {
                source.update(dataObject: dataObject)
                completion(nil)
            } else {
                networkManager.fetchFeedFrom(sourceURL: dataObject.sourceURL) { (feed, error) in
                    if let error = error {
                        completion(error)
                        return
                    } else if let feed = feed {
                        source.update(feed: feed)
                        self.storageManager.update(source: source)
                    }
                    completion(nil)
                }
            }
        }
    }
    
    func updateFeed(completion: @escaping (NetworkError?) -> ()) {
        DispatchQueue.global(qos: .userInitiated).async {
            let group = DispatchGroup()
            var finalError: NetworkError? = nil
            for source in self.sources {
                group.enter()
                self.networkManager.fetchFeedFrom(sourceURL: source.sourceURL) { (feed, error) in
                    if let feed = feed {
                        source.update(feed: feed)
                    } else if let error = error {
                        finalError = error
                    }
                    group.leave()
                }
            }
            group.notify(queue: .main) {
                completion(finalError)
            }
        }
    }
    
    private func sourceWith(id: String) -> Source? {
        return sources.first(where: { $0.identifier == id })
    }
    
    func removeSourceWith(dataObject: SourceDataObject) {
        if let dataObjectIndex = sources.firstIndex(where: { $0.identifier == dataObject.identifier }) {
            storageManager.remove(source: sources[dataObjectIndex])
            sources.remove(at: dataObjectIndex)
        }
    }
    
    func addSourceWith(dataObject: SourceDataObject, completion: @escaping (NetworkError?) -> ()) {
        let newSource = Source(dataObject: dataObject)
        networkManager.fetchFeedFrom(sourceURL: newSource.sourceURL) { (feed, error) in
            if let error = error {
                completion(error)
                return
            } else if let feed = feed {
                newSource.update(feed: feed)
                self.storageManager.add(source: newSource)
                self.sources.append(newSource)
            }
            completion(nil)
        }
    }
}

