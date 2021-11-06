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
import Domain

class ControllerFactory {
    
    static func makeHome(url: URL, getCharacter: GetCharacters) -> HomeViewController {
        
        let controller = HomeViewController.instantiate()
        let urlValidator = URLValidatorAdapter()
        let presenter = HomePresenter(url: url, alertView: WeakVarProxy(controller), urlValidator: urlValidator, getCharacters: getCharacter, loadingView: WeakVarProxy(controller), characterView: WeakVarProxy(controller))
        controller.requestCharacters = presenter.requestCharacters
        
        return controller
    }
}
