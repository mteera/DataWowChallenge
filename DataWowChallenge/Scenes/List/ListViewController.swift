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
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBinding()
        viewModel?.input.initialLoad()
    }
    
    private func setupBinding() {
        viewModel?.output.didLoadList = { [weak self] displayModel in
            guard let self else { return }
            list = displayModel
            tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: PokemonTableViewCell.identifier)
    }
}

// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier, for: indexPath) as? PokemonTableViewCell, let cellModel = list?[indexPath.row] else { return UITableViewCell() }
        cell.configure(with: cellModel)
        return cell
    }
}
