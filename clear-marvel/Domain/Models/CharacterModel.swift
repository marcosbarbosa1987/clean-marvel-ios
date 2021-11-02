//
//  CharacterModel.swift
//  Domain
//
//  Created by Marcos Barbosa on 16/10/21.
//

import Foundation

public struct CharacterModel: Model {
    public var data: [CharacterData?]?
    
    public init(data: [CharacterData]) {
        self.data = data
    }
}

public struct CharacterData: Model {
    public var results: [CharacterResult?]?
}

public struct CharacterResult: Model {
    public var id: Int?
    public var name: String?
    public var thumbnail: CharacterThumb?
}

public struct CharacterThumb: Model {
    public var path: String?
    public var extensionType: String?
    
    enum CodingKeys: String, CodingKey {
        case path = "path"
        case extensionType = "extension"
    }
}
