//
//  HomeComposer.swift
//  Main
//
//  Created by Marcos Barbosa on 06/11/21.
//

import Foundation
import UI
import Presentation
import Validations
import Domain

public final class HomeComposer {
    
    public static func composeControllerWith(url: URL, getCharacter: GetCharacters) -> HomeViewController {
        let controller = HomeViewController.instantiate()
        let urlValidator = URLValidatorAdapter()
        let presenter = HomePresenter(url: url, alertView: WeakVarProxy(controller), urlValidator: urlValidator, getCharacters: getCharacter, loadingView: WeakVarProxy(controller), characterView: WeakVarProxy(controller))
        controller.requestCharacters = presenter.requestCharacters
        return controller
    }
}
