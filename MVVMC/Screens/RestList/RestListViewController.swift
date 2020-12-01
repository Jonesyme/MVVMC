//
//  RestListViewController.swift
//  MVVMC
//
//  Created by Mike Jones on 10/31/20.
//  Copyright © 2020 Michael Jones. All rights reserved.
//

import UIKit

class RestListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    private var viewModel: RestListViewModel!
    private let refreshControl = UIRefreshControl()
    
    public static func createFromStoryboard(viewModel: RestListViewModel) -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RestListViewController") as! Self
        viewController.viewModel = viewModel
        viewController.title = "Restaurants"
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(refreshTableData(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.rowHeight = RestCell.rowHeight
        
        bindViewToViewModel()
        viewModel.fetchData()
    }
    
    @objc private func refreshTableData(_ sender: Any) {
        viewModel.clearData()
        viewModel.fetchData()
    }
    
    private func bindViewToViewModel() {
        viewModel.delegate = self
    }
}

extension RestListViewController: ViewModelBindingDelegate {
    func updateView(_ errorMessage: String? = nil) {
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
        if let message = errorMessage {
            let alertController = UIAlertController(title: "Network Error", message: message, preferredStyle: .alert);
            let okAction = UIAlertAction(title: "OK", style: .cancel)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension RestListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RestCell.identifier) as? RestCell else {
            assertionFailure("Unable to dequeue cell")
            return UITableViewCell()
        }
        guard let note = viewModel.item(atRow: indexPath.row) else {
            return cell
        }
        cell.configureCell(viewModel: RestCellViewModel(note))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

