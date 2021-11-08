//
//  CharacterModel.swift
//  Domain
//
//  Created by Marcos Barbosa on 16/10/21.
//

import Foundation

public struct CharacterModel: Model {
    public var data: CharacterData?
    
    public init(data: CharacterData?) {
        self.data = data
    }
}

public struct CharacterData: Model {
    public var offset: Int?
    public var total: Int?
    public var results: [CharacterResult?]?
    
    public init(offSet: Int?, total: Int?, results:[CharacterResult?]?) {
        self.offset = offSet
        self.total = total
        self.results = results
    }
}

public struct CharacterResult: Model {
    public var id: Int?
    public var name: String?
    public var thumbnail: CharacterThumb?
    
    public init(id: Int?, name: String?, thumbnail: CharacterThumb?) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
    }
}

public struct CharacterThumb: Model {
    public var path: String?
    public var extensionType: String?
    
    enum CodingKeys: String, CodingKey {
        case path = "path"
        case extensionType = "extension"
    }
    
    public init(path: String, extensionType: String?) {
        self.path = path
        self.extensionType = extensionType
    }
}
