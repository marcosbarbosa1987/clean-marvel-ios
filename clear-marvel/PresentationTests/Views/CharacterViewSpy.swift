//
//  CharacterViewSpy.swift
//  PresentationTests
//
//  Created by Marcos Barbosa on 04/11/21.
//

import Foundation
import Presentation

class CharacterViewSpy: CharactersView {
    
    var emit: ((CharactersViewModel) -> Void)?
    
    func observe(completion: @escaping(CharactersViewModel) -> Void) {
        self.emit = completion
    }
    
    func displayCharacter(_ viewModel: CharactersViewModel) {
        self.emit?(viewModel)
    }
}
