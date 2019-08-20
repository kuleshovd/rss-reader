//
//  SourceListViewModel.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 10/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import Foundation

protocol SourceListViewModelDelegate: CoordinationDelegate {
    func openAddSource()
    func openChangeSourceWith(changeDataObject: SourceDataObject)
}

class SourceListViewModel {
    
    private let sourceManager: SourceRetrieving & SourceRemoving
    private var sourceDataObjects: [SourceDataObject]
    
    weak var coordinationDelegate: SourceListViewModelDelegate?
    
    init(sourceManager: SourceRetrieving & SourceRemoving) {
        self.sourceManager = sourceManager
        sourceDataObjects = sourceManager.getSourceDataObjects()
    }
    
    func updateSourceDataObjects() {
        sourceDataObjects = sourceManager.getSourceDataObjects()
    }
    
    func numberOfSources() -> Int {
        return sourceDataObjects.count
    }
    
    func nameOfSourceAt(index: Int) -> String {
        return sourceDataObjects[index].name
    }
    
    func removeRowAt(index: Int) {
        sourceManager.removeSourceWith(dataObject: sourceDataObjects[index])
        updateSourceDataObjects()
    }
    
    func didTapAddSourceButton() {
        coordinationDelegate?.openAddSource()
    }
    
    func didTapChangeSourceAt(index: Int) {
        coordinationDelegate?.openChangeSourceWith(changeDataObject: sourceDataObjects[index])
    }
    
}
