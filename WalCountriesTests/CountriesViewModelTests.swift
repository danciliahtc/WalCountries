//
//  CountriesViewModelTests.swift
//  WalCountriesTests
//
//  Created by Dancilia Harmon   on 3/19/25.
//

import XCTest
@testable import WalCountries

class CountriesViewModelTests: XCTestCase {

    var viewModel: CountriesViewModel!
    var mockNetworkManager: MockNetworkManager?
    var mockDelegate: MockCountriesViewModelDelegate?
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        mockDelegate = MockCountriesViewModelDelegate()
        viewModel = CountriesViewModel(networkManager: mockNetworkManager!)
        viewModel.delegate = mockDelegate
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    func testFetchCountries_Success() {
        let expectation = XCTestExpectation(description: "Fetch countries successfully")
        
        mockNetworkManager?.shouldReturnError = false
        viewModel.fetchCountries()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(self.viewModel.countries.count, 2)
            XCTAssertEqual(self.viewModel.filteredCountries.count, 2)
            XCTAssertTrue(self.mockDelegate!.didUpdateCountriesCalled)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.5)
    }
    
    func testFetchCountries_Failure() {
        let expectation = XCTestExpectation(description: "Fetch countries failed")
        
        mockNetworkManager?.shouldReturnError = true
        viewModel.fetchCountries()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertTrue(self.mockDelegate!.didFailWithErrorCalled)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFilterCountries_WithValidSearchText() {
        viewModel.countries = [
            Country(name: "United States", region: "NA", code: "US", capital: "Washington, D.C."),
            Country(name: "Canada", region: "NA", code: "CA", capital: "Ottawa")
        ]
        
        viewModel.filterCountries(by: "Canada")
        
        XCTAssertEqual(viewModel.filteredCountries.count, 1)
        XCTAssertEqual(viewModel.filteredCountries.first?.name, "Canada")
    }
    
    func testFilterCountries_WithEmptySearchTest() {
        viewModel.countries = [
            Country(name: "United States", region: "NA", code: "US", capital: "Washington, D.C."),
            Country(name: "Canada", region: "NA", code: "CA", capital: "Ottawa")
        ]
        
        viewModel.filterCountries(by: "")
        
        XCTAssertEqual(viewModel.filteredCountries.count, 2)
    }
}

class MockCountriesViewModelDelegate: CountriesViewModelDelegate {
    var didUpdateCountriesCalled = false
    var didFailWithErrorCalled = false
    
    func didUpdateCountries() {
        didUpdateCountriesCalled = true
    }
    
    func didFailWithError(_ message: String) {
        didFailWithErrorCalled = true
    }
}
