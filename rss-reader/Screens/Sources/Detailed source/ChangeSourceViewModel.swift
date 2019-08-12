//
//  ChangeSourceViewModel.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 10/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import Foundation

class ChangeSourceViewModel {
    
    private let sourceManager: SourceUpdating
    private let changeDataObject: SourceDataObject
    
    weak var coordinationDelegate: CoordinationDelegate?
    
    init(sourceManager: SourceUpdating, changeDataObject: SourceDataObject) {
        self.sourceManager = sourceManager
        self.changeDataObject = changeDataObject
    }
}

extension ChangeSourceViewModel: DetailedSourceViewModel {
    
    func validate(name: String?, URLString: String?, completion: @escaping (String?) ->()) {
        guard let name = name, !name.isEmpty else {
            completion("Name shouldn't be empty!")
            return
        }
        guard let URLString = URLString, let sourceURL = URL(string: URLString) else {
            completion("Check URL!")
            return
        }
        
        let shouldValidate = changeDataObject.sourceURL != sourceURL
        
        changeDataObject.update(name: name, sourceURL: sourceURL)
        
        sourceManager.updateSourceWith(dataObject: changeDataObject, shouldValidate: shouldValidate) { (error) in
            completion(error?.description())
        }
    }
    
    func finish() {
        coordinationDelegate?.finished()
    }
    
    func getName() -> String? {
        return changeDataObject.name
    }
    
    func getURLString() -> String? {
        return changeDataObject.sourceURL.absoluteString
    }
}
