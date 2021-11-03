//
//  URLValidationsTests.swift
//  ValidationsTests
//
//  Created by Marcos Barbosa on 02/11/21.
//

import XCTest
import Presentation
import Validations

class URLValidationsTests: XCTestCase {
    
    func test_invalid_url() {
        let sut = URLValidatorAdapter()
        XCTAssertFalse(sut.isValid(URL(string: "wrong-url.com")!))
    }
    
    func test_valid_url() {
        let sut = URLValidatorAdapter()
        XCTAssertTrue(sut.isValid(URL(string: "http://www.google.com")!))
    }
    
}
