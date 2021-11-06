//
//  WeakVarProxy.swift
//  Main
//
//  Created by Marcos Barbosa on 06/11/21.
//

import Foundation
import Presentation

class WeakVarProxy<T: AnyObject> {
    
    private weak var instance: T?
    
    init(_ instance: T) {
        self.instance = instance
    }
}

extension WeakVarProxy: AlertView where T: AlertView {
    func display(_ viewModel: AlertViewModel) {
        instance?.display(viewModel)
    }
}

extension WeakVarProxy: LoadingView where T: LoadingView {
    func display(_ viewModel: LoadingViewModel) {
        instance?.display(viewModel)
    }
}

extension WeakVarProxy: CharactersView where T: CharactersView {
    func displayCharacter(_ viewModel: CharactersViewModel) {
        instance?.displayCharacter(viewModel)
    }
}
