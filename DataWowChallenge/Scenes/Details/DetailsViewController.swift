//
//  DetailsViewController.swift
//  DataWowChallenge
//
//  Created by Chace Teera on 17/5/2567 BE.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var viewModel: DetailsViewModel?
    
    private var sections: [DetailsViewSection]?
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        
        activityIndicator.startAnimating()
        setupTableView()
        setupBinding()
        viewModel?.input.initialLoad()
    }
    
    private func setupBinding() {
        viewModel?.output.didLoadSections = { [weak self] sections in
            guard let self else { return }
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            self.sections = sections
            tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        
        tableView.register(UINib(nibName: "DetailsHeroTableViewCell", bundle: nil), forCellReuseIdentifier: DetailsHeroTableViewCell.identifier)
        tableView.register(UINib(nibName: "DetailsInformationTableViewCell", bundle: nil), forCellReuseIdentifier: DetailsInformationTableViewCell.identifier)
    }
}

// MARK: - UITableViewDataSource
extension DetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = sections?[indexPath.section] else { return UITableViewCell() }
        
        switch section {
        case .hero(let displayModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsHeroTableViewCell.identifier, for: indexPath) as? DetailsHeroTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: displayModel)
            return cell // Return the configured DetailsHeroTableViewCell
        case .information(let displayModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsInformationTableViewCell.identifier, for: indexPath) as? DetailsInformationTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: displayModel)
            return cell // Return the configured DetailsInformationTableViewCell
        }
    }

}

// MARK: - UITableViewDelegate
extension DetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
