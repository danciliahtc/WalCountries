//
//  CountriesViewModel.swift
//  WalCountries
//
//  Created by Dancilia Harmon   on 3/19/25.
//

import Foundation

protocol CountriesViewModelDelegate: AnyObject {
    func didUpdateCountries()
    func didFailWithError(_ message: String)
}

class CountriesViewModel {
    
    private let networkManager: NetworkServiceProtocol
    weak var delegate: CountriesViewModelDelegate?
    
    internal(set) var countries: [Country] = []
    internal(set) var filteredCountries: [Country] = []
    
    init(networkManager: NetworkServiceProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchCountries() {
        networkManager.fetch(endpoint: Endpoints.countriesURL, responseType: [Country].self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedCountries):
                    self?.countries = fetchedCountries
                    self?.filteredCountries = fetchedCountries
                    self?.delegate?.didUpdateCountries()
                case .failure(let error):
                    self?.delegate?.didFailWithError(error.localizedDescription)
            }
        }
    }
}
    
    func filterCountries(by searchText: String) {
        if searchText.isEmpty {
            filteredCountries = countries
        } else {
            let lowercasedText = searchText.lowercased()
            filteredCountries = countries.filter { country in
                return country.name.lowercased().contains(lowercasedText) || country.code.lowercased().contains(lowercasedText)
            }
        }
        delegate?.didUpdateCountries()
    }
}
