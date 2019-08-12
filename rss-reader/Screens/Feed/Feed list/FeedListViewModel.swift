//
//  FeedListViewModel.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 10/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import Foundation

protocol FeedListViewModelDelegate: CoordinationDelegate {
    func openArticleWith(dataObject: ArticleDataObject)
}

class FeedListViewModel {
    
    private let indicatorTitleLength = 3
    
    private let sourceManager: FeedRetrieving & FeedUpdatable
    private var feedDataObjects: [FeedDataObject]
    
    weak var coordinationDelegate: FeedListViewModelDelegate?
    
    init(sourceManager: FeedRetrieving & FeedUpdatable) {
        self.sourceManager = sourceManager
        feedDataObjects = sourceManager.getFeedDataObjects()
    }
    
    func fetchFeed(completion: @escaping (String?) -> ()) {
        sourceManager.updateFeed { (error) in
            completion(error?.description())
        }
    }
    
    func updateFeedDataObjects() {
        feedDataObjects = sourceManager.getFeedDataObjects()
    }
    
    func numberOfSources() -> Int {
        return feedDataObjects.count
    }
    
    func numberOfArticlesInSourceAt(index: Int) -> Int {
        return feedDataObjects[index].articles.count
    }
    
    func articleCellViewModelAt(indexPath: IndexPath) -> ArticleCellViewModel {
        let article = feedDataObjects[indexPath.section].articles[indexPath.row]
        return ArticleCellViewModel(title: article.title, descriptiontext: article.descriptionText, imageURL: article.imageURL)
    }
    
    func feedTitleWith(index: Int) -> String {
        return feedDataObjects[index].name
    }
    
    func indicatorTitles() -> [String] {
        return feedDataObjects.map { String($0.name.uppercased().prefix(indicatorTitleLength)) }
    }
    
    func didTapArticleAt(indexPath: IndexPath) {
        let article = feedDataObjects[indexPath.section].articles[indexPath.row]
        coordinationDelegate?.openArticleWith(dataObject: article)
    }
    
}
