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
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
    }
    
    private func setupTableView() {
        tableView.dataSource = self
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
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: DetailsHeroTableViewCell.identifier, for: indexPath) as? DetailsHeroTableViewCell
                else {
                return UITableViewCell()
            }
            
            cell.configure(with: displayModel)
        case .information(let displayModel):
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: DetailsInformationTableViewCell.identifier, for: indexPath) as? DetailsInformationTableViewCell
                else {
                return UITableViewCell()
            }
            
            cell.configure(with: displayModel)
        }
        
        return UITableViewCell()
    }
}
