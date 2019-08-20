//
//  DetailedSourceViewModel.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 10/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import Foundation

class AddSourceViewModel {
    
    private let sourceManager: SourceAdding
    
    weak var coordinationDelegate: CoordinationDelegate?
    
    init(sourceManager: SourceAdding) {
        self.sourceManager = sourceManager
    }
    
}

extension AddSourceViewModel: DetailedSourceViewModel {
    
    func validate(name: String?, URLString: String?, completion: @escaping (String?) ->()) {
        guard let name = name, !name.isEmpty else {
            completion("Name shouldn't be empty!")
            return
        }
        guard let URLString = URLString, let sourceURL = URL(string: URLString) else {
            completion("Check URL!")
            return
        }
        
        let newDataObject = SourceDataObject(name: name, sourceURL: sourceURL)
        
        sourceManager.addSourceWith(dataObject: newDataObject) { (error) in
            completion(error?.description())
        }
    }
    
    func finish() {
        coordinationDelegate?.finished()
    }
    
    func getName() -> String? {
        return nil
    }
    
    func getURLString() -> String? {
        return nil
    }
}
