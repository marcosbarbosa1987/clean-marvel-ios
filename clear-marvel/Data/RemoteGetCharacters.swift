//
//  RemoteGetCharacters.swift
//  Data
//
//  Created by Marcos Barbosa on 16/10/21.
//

import Foundation

public class RemoteGetCharacters {
    
    private let url: URL
    private let httpGetRequest: HttpGetRequest
    
    public init(url: URL, httpGetRequest: HttpGetRequest) {
        self.url = url
        self.httpGetRequest = httpGetRequest
    }
    
    public func get() {
        httpGetRequest.get(url: url)
    }
}
