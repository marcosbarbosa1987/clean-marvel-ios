//
//  CharacterModel.swift
//  Domain
//
//  Created by Marcos Barbosa on 16/10/21.
//

import Foundation

public struct CharacterModel: Model {
    public var name: String?
    public var image: String?
    
    public init(name: String?, image: String?) {
        self.name = name
        self.image = image
    }
}
