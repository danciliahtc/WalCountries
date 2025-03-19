//
//  CountryModelTests.swift
//  WalCountriesTests
//
//  Created by Dancilia Harmon   on 3/17/25.
//

import XCTest
@testable import WalCountries

final class CountryModelTests: XCTestCase {

    func testCountryModel_CanDecodeValidJSON() {
        let json = """
        {"name": "United States", "region": "NA", "code": "US", "capital": "Washington, D.C."}
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let country = try? decoder.decode(Country.self, from: json)
        
        XCTAssertNotNil(country)
        XCTAssertEqual(country?.name, "United States")
        XCTAssertEqual(country?.region, "NA")
        XCTAssertEqual(country?.code, "US")
        XCTAssertEqual(country?.capital, "Washington, D.C.")
    }
}
