//
//  GetCharacters.swift
//  Domain
//
//  Created by Marcos Barbosa on 16/10/21.
//

import Foundation

public protocol GetCharacters {
    func get(url: URL, completion: @escaping(Result<CharacterModel?, DomainError>) -> Void)
}
