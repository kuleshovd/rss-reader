//
//  Source.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 10/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import Foundation

class Source {
    
    let identifier: String
    private(set) var name: String
    private(set) var sourceURL: URL
    private(set) var feed: Feed?
    
    init(dataObject: SourceDataObject) {
        identifier = UUID().uuidString
        self.name = dataObject.name
        self.sourceURL = dataObject.sourceURL
    }
    
    init(entity: SourceEntity) {
        self.identifier = entity.identifier
        self.name = entity.name
        self.sourceURL = entity.sourceURL
    }
    
    func update(dataObject: SourceDataObject) {
        self.name = dataObject.name
        self.sourceURL = dataObject.sourceURL
    }
    
    func update(feed: Feed) {
        self.feed = feed
    }
    

}
