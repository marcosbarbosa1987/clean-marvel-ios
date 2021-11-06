//
//  HomeViewFactory.swift
//  Main
//
//  Created by Marcos Barbosa on 02/11/21.
//

import Foundation
import UI
import Presentation
import Validations
import Data
import Infra
import Domain

class HomeViewFactory {
    
    static func makeController(url: URL, getCharacter: GetCharacters) -> HomeViewController {
        
        let controller = HomeViewController.instantiate()
        let urlValidator = URLValidatorAdapter()
        let presenter = HomePresenter(url: url, alertView: controller, urlValidator: urlValidator, getCharacters: getCharacter, loadingView: controller, characterView: controller)
        controller.requestCharacters = presenter.requestCharacters
        
        return controller
    }
}

class UseCaseFactory {
    
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
