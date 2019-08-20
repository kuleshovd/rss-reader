//
//  SourceEntity.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 11/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import Foundation

struct SourceEntity: Codable {
    
    let identifier: String
    let name: String
    let sourceURL: URL
    
    init(source: Source) {
        identifier = source.identifier
        self.name = source.name
        self.sourceURL = source.sourceURL
    }
}
