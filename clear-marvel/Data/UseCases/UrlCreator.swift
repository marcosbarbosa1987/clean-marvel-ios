//
//  UrlCreator.swift
//  Data
//
//  Created by Marcos Barbosa on 17/10/21.
//

import Foundation

final public class UrlCreator {
    
    private(set) var baseURL: String
    private(set) var privateKey: String
    private(set) var publicKey: String
    private(set) var endpoint: UrlCreatorEndpoint
    private(set) var timestamp: Int64
    private(set) var md5Generator: MD5Generator
    
    public init(model: UrlCreatorModel, md5Generator: MD5Generator) {
        self.baseURL = model.baseURL
        self.privateKey = model.privateKey
        self.publicKey = model.publicKey
        self.endpoint = model.endpoint
        self.timestamp = model.timestamp
        self.md5Generator = md5Generator
    }
    
    public func getUrl() -> URL? {
        
        let hash = md5Generator.generateHash(from: timestamp, and: privateKey, and: publicKey)
        
        if !hash.isEmpty {
            return createUrl(with: hash)
        }
        return nil
    }
    
    private func createUrl(with hash: String) -> URL? {
        switch endpoint {
        case .characters:
            return URL(string: "\(baseURL)\(UrlCreatorEndpoint.characters.rawValue)ts=\(timestamp)&apikey=\(publicKey)&hash=\(hash)")
        case .comics:
            return URL(string: "\(baseURL)\(UrlCreatorEndpoint.comics.rawValue)ts=\(timestamp)&apikey=\(publicKey)&hash=\(hash)")
        default:
            return nil
        }
    }
}

public struct UrlCreatorModel {
    public var baseURL: String
    public var endpoint: UrlCreatorEndpoint
    public var privateKey: String
    public var publicKey: String
    public var timestamp: Int64
    
    public init(baseURL: String, endpoint: UrlCreatorEndpoint, privateKey: String, publicKey: String, timestamp: Int64) {
        self.baseURL = baseURL
        self.endpoint = endpoint
        self.privateKey = privateKey
        self.publicKey = publicKey
        self.timestamp = timestamp
    }
}
