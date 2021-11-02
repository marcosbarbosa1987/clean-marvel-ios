//
//  URLValidaatorSpy.swift
//  PresentationTests
//
//  Created by Marcos Barbosa on 02/11/21.
//

import Foundation
import Presentation

class URLValidatorSpy: URLValidator {
    
    var isValid = true
    var url: URL?
    
    func isValid(_ url: URL) -> Bool {
        self.url = url
        return isValid
    }
    
    func simulate() {
        self.isValid = false
    }
}
