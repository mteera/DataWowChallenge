import UIKit

class ListViewController: UIViewController {
    
    var viewModel: ListViewModel?
    private var list: [PokemonTableViewCellDisplayModel]?
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlDidPull(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pokemon List"
        activityIndicator.startAnimating()
        setupTableView()
        setupSearchBar()
        setupBinding()
        viewModel?.input.initialLoad()
    }
    
    private func setupBinding() {
        viewModel?.output.didLoadList = { [weak self] displayModel in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.refreshControl.endRefreshing()
            self.refreshControl.isHidden = true
            
            self.list = displayModel
            self.tableView.reloadData()
            self.updatePlaceholder()
        }
        
        viewModel?.output.didReceiveError = { [weak self] message in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.refreshControl.endRefreshing()
            self.refreshControl.isHidden = true
            
            self.updatePlaceholder()
            
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: PokemonTableViewCell.identifier)
        tableView.refreshControl = refreshControl
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
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
    
    @objc private func refreshControlDidPull(_ sender: UIRefreshControl) {
        viewModel?.input.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier, for: indexPath) as? PokemonTableViewCell, let pokemon = list?[indexPath.row] else {
            return UITableViewCell()
        }
        
        
        cell.configure(with: pokemon)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let details = list?[indexPath.row] else { return }
        
        let detailsViewController = DetailsViewController()
        detailsViewController.viewModel = DetailsViewModel(context: DetailsViewContext(name: details.name))
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.input.search(with: searchText)
    }
}
