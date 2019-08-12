//
//  SourceListViewController.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 10/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import UIKit

class SourceListViewController: UIViewController {
    
    private let sourceCellIdentifier = "sourceCell"
    
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: SourceListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.updateSourceDataObjects()
        tableView.reloadData()
    }
    
    
    //MARK: actions
    
    @IBAction func didTapAddSourceButton(_ sender: Any) {
        viewModel.didTapAddSourceButton()
    }
    

}

extension SourceListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didTapChangeSourceAt(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeRowAt(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension SourceListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSources()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: sourceCellIdentifier, for: indexPath) as! SourceCell
        cell.setAppearance(sourceName: viewModel.nameOfSourceAt(index: indexPath.row))
        return cell
    }
    
}
