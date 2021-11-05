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
    
    static func makeController() -> HomeViewController {
        
        let urlModel = UrlCreatorModel(baseURL: UrlConstants.baseURL.rawValue,
                                       endpoint: .characters,
                                       privateKey: UrlConstants.privateKey.rawValue,
                                       publicKey: UrlConstants.publicKey.rawValue,
                                       timestamp: Date().currentTimeMillis())
        guard let url = UrlCreator(model: urlModel).getUrl() else { return HomeViewController()}
        
        let controller = HomeViewController(nibName: "HomeViewController", bundle: Bundle(for: HomeViewController.self))
        let urlValidator = URLValidatorAdapter()
        let alamofireAdapter = AlamofireAdapter()
        let remoteGetCharacter = RemoteGetCharacters(url: url, httpGetRequest: alamofireAdapter)
        
        let presenter = HomePresenter(alertView: controller, urlValidator: urlValidator, getCharacters: remoteGetCharacter, loadingView: controller, characterView: controller)
        
        controller.url = url
        controller.requestCharacters = presenter.requestCharacters
        
        return controller
    }
}
