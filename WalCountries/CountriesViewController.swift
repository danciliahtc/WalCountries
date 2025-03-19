//
//  ViewController.swift
//  WalCountries
//
//  Created by Dancilia Harmon   on 3/14/25.
//

import UIKit

class CountriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    
    private var viewModel: CountriesViewModel
    internal let tableView = UITableView()
    internal let searchController = UISearchController(searchResultsController: nil)
 
    init(viewModel: CountriesViewModel = CountriesViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Countries"
        view.backgroundColor = .white
        
       // viewModel = CountriesViewModel()
        viewModel.delegate = self
        
        setupTableView()
        setupSearchController()
        
        viewModel.fetchCountries()
    }
    
    // Setup TableView
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CountryCell.self, forCellReuseIdentifier: "CountryCell")
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
        
        // Setup Search Controller
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Countries"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    // UITableViewDataSourceMethods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as? CountryCell else {
            return UITableViewCell()
        }
        let country = viewModel.filteredCountries[indexPath.row]
        cell.configure(with: country)
        return cell
    }

    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        viewModel.filterCountries(by: searchText)
    }
}

extension CountriesViewController: CountriesViewModelDelegate {
    func didUpdateCountries() {
        tableView.reloadData()
    }
    
    func didFailWithError(_ message: String) {
        print("Error: \(message)")
    }
}
