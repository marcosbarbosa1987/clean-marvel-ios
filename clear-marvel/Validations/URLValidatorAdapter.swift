//
//  URLValidatorAdapter.swift
//  Validations
//
//  Created by Marcos Barbosa on 02/11/21.
//

import Foundation
import Presentation

public final class URLValidatorAdapter: URLValidator {
    
    public init(){}
    
    public func isValid(_ url: URL) -> Bool {
        if url.host != nil {
            return true
        }
        return false
    }
}
