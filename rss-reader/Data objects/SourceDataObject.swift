//
//  SourceDataObject.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 11/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import Foundation

class SourceDataObject {
    
    private(set) var identifier: String?
    var name: String
    var sourceURL: URL
    
    
    init(source: Source) {
        identifier = source.identifier
        self.name = source.name
        self.sourceURL = source.sourceURL
    }
    
    init(name: String, sourceURL: URL) {
        self.name = name
        self.sourceURL = sourceURL
    }
    
    func update(name: String, sourceURL: URL) {
        self.name = name
        self.sourceURL = sourceURL
    }
}
