//
//  CharacterView.swift
//  Presentation
//
//  Created by Marcos Barbosa on 04/11/21.
//

import Foundation
import Domain

public protocol CharactersView: AnyObject {
    func displayCharacter(_ viewModel: CharactersViewModel)
}

public struct CharactersViewModel {
    public var characters: CharacterModel
    
    public init(characters: CharacterModel) {
        self.characters = characters
    }
}


