//
//  FeedListViewController.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 10/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import UIKit

class FeedListViewController: UIViewController {
    
    private let articleCellHeight: CGFloat = 150.0

    private let articleCellIdentifier = "articleCell"
    private let refreshControl = UIRefreshControl()
    
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: FeedListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        refreshControl.beginRefreshing()
        refreshAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.updateFeedDataObjects()
        tableView.reloadData()
    }
    
    //MARK: actions
    
    @objc func refreshAction() {
        viewModel.fetchFeed { (errorString) in
            self.refreshControl.endRefreshing()
            self.viewModel.updateFeedDataObjects()
            self.tableView.reloadData()
            
            if let errorString = errorString {
                Alert.showErrorAlert(on: self, message: errorString)
            }
        }
    }

}

extension FeedListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didTapArticleAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return articleCellHeight
    }
}

extension FeedListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSources()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.feedTitleWith(index: section)
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return (viewModel.numberOfSources() > 1) ? viewModel.indicatorTitles() : nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfArticlesInSourceAt(index: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: articleCellIdentifier, for: indexPath) as! ArticleCell
        cell.setAppearance(viewModel: viewModel.articleCellViewModelAt(indexPath: indexPath))
        return cell
    }
    
}
