//
//  UrlCreator.swift
//  Data
//
//  Created by Marcos Barbosa on 17/10/21.
//

import Foundation

final public class UrlCreator: MD5Generator {
    
    private(set) var baseURL: String
    private(set) var privateKey: String
    private(set) var publicKey: String
    private(set) var endpoint: UrlCreatorEndpoint
    private(set) var timestamp: Int64
    
    public init(model: UrlCreatorModel) {
        self.baseURL = model.baseURL
        self.privateKey = model.privateKey
        self.publicKey = model.publicKey
        self.endpoint = model.endpoint
        self.timestamp = model.timestamp
    }
    
    public func getUrl() -> URL? {
        
        let hash = generateHash(from: timestamp, and: privateKey, and: publicKey)
        
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
    
    public func generateHash(from timestamp: Int64, and privateKey: String, and publicKey: String) -> String {
        return MD5(from: "\(timestamp)\(privateKey)\(publicKey)")
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
