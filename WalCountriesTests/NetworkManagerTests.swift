//
//  NetworkManagerTests.swift
//  WalCountriesTests
//
//  Created by Dancilia Harmon   on 3/14/25.
//

import XCTest
@testable import WalCountries

final class NetworkManagerTests: XCTestCase {
    
    var networkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        networkManager = MockNetworkManager()
    }
    
    override func tearDown() {
        networkManager = nil
        super.tearDown()
    }
    
    // MARK: - Success Test Case
    func testFetchCountries_Success() {
        networkManager.shouldReturnError = false
        networkManager.shouldReturnDecodingError = false
        
        let expectation = XCTestExpectation(description: "Fetch countries successfully")
        
        networkManager.fetch(endpoint: "testURL", responseType: [Country].self) { result in
            switch result {
            case .success(let countries):
                XCTAssertEqual(countries.count, 2)
                XCTAssertEqual(countries.first?.name, "United States")
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success, got failure instead")
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // MARK: - Invalid URL Test Case
    func testFetchCountries_Failure_InvalidURL() {
        networkManager.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Invalid URL failure")
        
        networkManager.fetch(endpoint: "testURL", responseType: [Country].self) { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success instead")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, NetworkError.invalidURL.localizedDescription)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchCountries_Failure_DecodingError() {
        networkManager.shouldReturnError = false
        networkManager.shouldReturnDecodingError = true
        
        let expectation = XCTestExpectation(description: "Decoding failure")
        
        networkManager.fetch(endpoint: "testURL", responseType: [Country].self) { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success instead")
            case .failure(let error):
                if case NetworkError.decodingError = error {
                    expectation.fulfill()
                } else {
                    XCTFail("Expected decoding error, got \(error)")
                }
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
