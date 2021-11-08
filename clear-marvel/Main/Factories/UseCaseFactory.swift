//
//  UseCaseFactory.swift
//  Main
//
//  Created by Marcos Barbosa on 06/11/21.
//

import Foundation
import Data
import Infra
import Domain

final class UseCaseFactory {
    
    private static let httpClient = AlamofireAdapter()
    
    static func getCharacterURL(endpoint: UrlCreatorEndpoint) -> URL {
        let urlModel = UrlCreatorModel(baseURL: UrlConstants.baseURL.rawValue,
                                       endpoint: endpoint,
                                       privateKey: UrlConstants.privateKey.rawValue,
                                       publicKey: UrlConstants.publicKey.rawValue,
                                       timestamp: Date().currentTimeMillis())
        return UrlCreator(model: urlModel).getUrl() ?? URL(string: "")!
    }
    
    static func makeRemoteGetCharacter() -> GetCharacters {
        let remoteGetCharacter = RemoteGetCharacters(url: getCharacterURL(endpoint: .characters), httpGetRequest: httpClient)
        return MainQueueDispatchDecorator(remoteGetCharacter)
    }
}
