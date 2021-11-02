//
//  URLValidator.swift
//  Presentation
//
//  Created by Marcos Barbosa on 02/11/21.
//

import Foundation

public protocol URLValidator {
    func isValid(_ url: URL) -> Bool
}
