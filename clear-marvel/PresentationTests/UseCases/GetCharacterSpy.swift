//
//  GetCharacterSpy.swift
//  PresentationTests
//
//  Created by Marcos Barbosa on 06/11/21.
//

import Foundation
import Domain

class GetCharacterSpy: GetCharacters {
    
    var url: URL?
    var completion: ((Result<CharacterModel?, DomainError>) -> Void)?
    
    func get(url: URL, completion: @escaping (Result<CharacterModel?, DomainError>) -> Void) {
        self.url = url
        self.completion = completion
    }

    func completeWithError(_ error: DomainError) {
        completion?(.failure(error))
    }
    
    func completeWithSuccess(_ data: CharacterModel?) {
        completion?(.success(data))
    }
}
