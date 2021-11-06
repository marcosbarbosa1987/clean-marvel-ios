//
//  UseCaseFactory.swift
//  Main
//
//  Created by Marcos Barbosa on 06/11/21.
//

import Foundation
import Data
import Infra

final class UseCaseFactory {
    
    static func getCharacterURL(endpoint: UrlCreatorEndpoint) -> URL {
        let urlModel = UrlCreatorModel(baseURL: UrlConstants.baseURL.rawValue,
                                       endpoint: endpoint,
                                       privateKey: UrlConstants.privateKey.rawValue,
                                       publicKey: UrlConstants.publicKey.rawValue,
                                       timestamp: Date().currentTimeMillis())
        return UrlCreator(model: urlModel).getUrl() ?? URL(string: "")!
    }
    
    static func makeRemoteGetCharacter() -> RemoteGetCharacters {
        let alamofireAdapter = AlamofireAdapter()
        return RemoteGetCharacters(url: UseCaseFactory.getCharacterURL(endpoint: .characters), httpGetRequest: alamofireAdapter)
    }
}
