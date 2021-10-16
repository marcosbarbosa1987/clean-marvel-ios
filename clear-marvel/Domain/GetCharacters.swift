//
//  GetCharacters.swift
//  Domain
//
//  Created by Marcos Barbosa on 16/10/21.
//

import Foundation

protocol GetCharacters {
    func get(completion: @escaping(Result<[CharacterModel?]?, Error>) -> Void)
}
