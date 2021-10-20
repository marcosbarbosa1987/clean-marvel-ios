//
//  RemoteGetCharacters.swift
//  Data
//
//  Created by Marcos Barbosa on 16/10/21.
//

import Foundation
import Domain

public class RemoteGetCharacters {
    
    public let url: URL
    public let httpGetRequest: HttpGetRequest
    
    public init(url: URL, httpGetRequest: HttpGetRequest) {
        self.url = url
        self.httpGetRequest = httpGetRequest
    }
    
    public func get(completion: @escaping(Result<CharacterModel?, DomainError>) -> Void) {
        httpGetRequest.get(from: url) { [weak self] (result) in
            
            guard self != nil else { return }
            
            switch result {
            case .success(let data):
                if let model: CharacterModel = data?.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.unexpected))
                }
                
            case .failure:
                completion(.failure(.unexpected))
            }
        }
    }
}
