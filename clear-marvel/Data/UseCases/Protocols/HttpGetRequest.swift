//
//  HttpGetRequest.swift
//  Data
//
//  Created by Marcos Barbosa on 16/10/21.
//

import Foundation

public protocol HttpGetRequest {
    func get(from url: URL)
}
