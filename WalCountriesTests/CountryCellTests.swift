//
//  CountryCellTests.swift
//  WalCountriesTests
//
//  Created by Dancilia Harmon   on 3/18/25.
//

import XCTest
@testable import WalCountries

class CountryCellTests: XCTestCase {

    var cell: CountryCell!
    
    override func setUp() {
        super.setUp()
        cell = CountryCell(style: .default, reuseIdentifier: "CountryCell")
    }

    override func tearDown() {
        cell = nil
        super.tearDown()
    }
    
    func testCellConfiguration_SetsLabelsCorrectly() {
        let country = Country(name: "United States", region: "NA", code: "US", capital: "Washington, D.C.")
        
        cell.configure(with: country)
        
        XCTAssertEqual(cell.nameLabel.text, "United States, NA    US")
        XCTAssertEqual(cell.capitalLabel.text, "Washington, D.C.")
    }
    
    func testAccessibilityLabels_AreSetCorrectly() {
        let country = Country(name: "United States", region: "NA", code: "US", capital: "Washington, D.C.")
        
        cell.configure(with: country)
        
        XCTAssertEqual(cell.nameLabel.accessibilityLabel, "United States, located in NA, with code US")
        XCTAssertEqual(cell.capitalLabel.accessibilityLabel, "Capital city: Washington, D.C.")
    }
    
    func testDynamicType_SupportsPreferredContentSize() {
        let expectedFont = UIFont.preferredFont(forTextStyle: .headline)
        let expectedSubFont = UIFont.preferredFont(forTextStyle: .subheadline)
        
        XCTAssertEqual(cell.nameLabel.font.fontDescriptor.fontAttributes[.textStyle] as? String, expectedFont.fontDescriptor.fontAttributes[.textStyle] as? String)
        
        XCTAssertEqual(cell.capitalLabel.font.fontDescriptor.fontAttributes[.textStyle] as? String, expectedSubFont.fontDescriptor.fontAttributes[.textStyle] as? String)
        
        XCTAssertEqual(cell.nameLabel.font.pointSize, expectedFont.pointSize)
        XCTAssertEqual(cell.capitalLabel.font.pointSize, expectedSubFont.pointSize)
    }
}
