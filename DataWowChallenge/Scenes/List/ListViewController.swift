//
//  ListViewController.swift
//  DataWowChallenge
//
//  Created by Chace Teera on 13/5/2567 BE.
//

import UIKit

class ListViewController: UIViewController {
    
    var viewModel: ListViewModel?
    private var list: [PokemonTableViewCellDisplayModel]?
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    
    private lazy var refreshControl: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        setupTableView()
        setupBinding()
        setupRefreshControl()
        viewModel?.input.initialLoad()
    }
    
    private func setupBinding() {
        viewModel?.output.didLoadList = { [weak self] displayModel in
            guard let self else { return }
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            refreshControl.endRefreshing()
            list = displayModel
            tableView.reloadData()
            updatePlaceholder()
        }
        
        viewModel?.output.didReceiveError = { [weak self] message in
            guard let self = self else { return }
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            updatePlaceholder()
            
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }

    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: PokemonTableViewCell.identifier)
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshControlDidPull(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func updatePlaceholder() {
        if list == nil || list?.isEmpty == true {
            let placeholderLabel = UILabel()
            placeholderLabel.text = "No data available"
            placeholderLabel.textAlignment = .center
            placeholderLabel.textColor = .gray
            tableView.backgroundView = placeholderLabel
        } else {
            tableView.backgroundView = nil
        }
    }
    
    @objc func refreshControlDidPull(_ sender: UIRefreshControl) {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        viewModel?.input.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = list?.count ?? .zero
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier, for: indexPath) as? PokemonTableViewCell, let cellModel = list?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.configure(with: cellModel)
        return cell
    }
}
