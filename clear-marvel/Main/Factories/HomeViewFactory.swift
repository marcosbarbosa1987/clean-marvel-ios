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

class HomeViewFactory {
    
    static func makeController() -> HomeViewController {
        
        let md5 = MD5Generator()
        let urlModel = UrlCreatorModel(baseURL: UrlConstants.baseURL.rawValue,
                                       endpoint: .characters,
                                       privateKey: UrlConstants.privateKey.rawValue,
                                       publicKey: UrlConstants.publicKey.rawValue,
                                       timestamp: Date().currentTimeMillis())
        let url = UrlCreator(model: urlModel, md5Generator: md5)
        
        let controller = HomeViewController(nibName: "HomeViewController", bundle: Bundle(for: HomeViewController.self))
        let urlValidator = URLValidatorAdapter()
        
        let presenter = HomePresenter(url: url, alertView: controller, urlValidator: urlValidator, getCharacters: <#T##GetCharacters#>, loadingView: controller)
        
        return controller
    }
}
