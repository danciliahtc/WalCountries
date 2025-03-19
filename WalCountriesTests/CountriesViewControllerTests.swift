//
//  WalCountriesTests.swift
//  WalCountriesTests
//
//  Created by Dancilia Harmon   on 3/14/25.
//

import XCTest
@testable import WalCountries

class CountriesViewControllerTests: XCTestCase {
    
    var viewController: CountriesViewController!
    var mockViewModel: MockCountriesViewModel!
    
    override func setUp() {
        super.setUp()
        mockViewModel = MockCountriesViewModel()
        viewController = CountriesViewController(viewModel: mockViewModel)
        viewController.loadViewIfNeeded()
        
        mockViewModel.fetchCountries()
        viewController.tableView.reloadData()
        
        mockViewModel.delegate = viewController
    }
    
    override func tearDown() {
        viewController = nil
        mockViewModel = nil
        super.tearDown()
    }
    
    func testTableView_HasCorrectNumberOfRows() {
        mockViewModel.countries = [
            Country(name: "United States", region: "NA", code: "US", capital: "Washington, D.C."),
            Country(name: "Canada", region: "NA", code: "CA", capital: "Ottawa")
        ]
        mockViewModel.filteredCountries = mockViewModel.countries
        
        viewController.tableView.reloadData()
        
        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), 2)
    }
    
    func testSearchFiltering_CorrectlyFiltersByName() {
        mockViewModel.countries = [
            Country(name: "United States", region: "NA", code: "US", capital: "Washington, D.C."),
            Country(name: "Canada", region: "NA", code: "CA", capital: "Ottawa")
        ]
        
        viewController.searchController.searchBar.text = "Canada"
        viewController.updateSearchResults(for: viewController.searchController)
        
        viewController.tableView.reloadData()
        
        XCTAssertEqual(mockViewModel.filteredCountries.count, 1)
        XCTAssertEqual(mockViewModel.filteredCountries.first?.name, "Canada")
    }
    
    func testSearchFiltering_CorrectlyFiltersByCapital() {
        mockViewModel.countries = [
            Country(name: "United States", region: "NA", code: "US", capital: "Washington, D.C."),
            Country(name: "Canada", region: "NA", code: "CA", capital: "Ottawa")
        ]
        
        viewController.searchController.searchBar.text = "Ottawa"
        viewController.updateSearchResults(for: viewController.searchController)
        
        XCTAssertEqual(mockViewModel.filteredCountries.count, 1)
        XCTAssertEqual(mockViewModel.filteredCountries.first?.capital, "Ottawa")
    }
}

class MockCountriesViewModel: CountriesViewModel {
    override func fetchCountries() {
        self.countries = [
            Country(name: "United States", region: "NA", code: "US", capital: "Washington, D.C."),
            Country(name: "Canada", region: "NA", code: "CA", capital: "Ottawa")
        ]
        self.filteredCountries = self.countries
        self.delegate?.didUpdateCountries()
    }
    
    override func filterCountries(by searchText: String) {
        if searchText.isEmpty {
            filteredCountries = countries
        } else {
            filteredCountries = countries.filter { $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.capital.lowercased().contains(searchText.lowercased())
            }
        }
        delegate?.didUpdateCountries()
    }
}
