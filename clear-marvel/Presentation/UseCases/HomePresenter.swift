//
//  HomePresenter.swift
//  Presentation
//
//  Created by Marcos Barbosa on 01/11/21.
//

import Foundation
import Domain

public class HomePresenter {
    
    private weak var alertView: AlertView?
    private let urlValidator: URLValidator
    private let getCharacters: GetCharacters
    private weak var loadingView: LoadingView?
    private weak var characterView: CharactersView?
    
    public init(alertView: AlertView, urlValidator: URLValidator, getCharacters: GetCharacters, loadingView: LoadingView, characterView: CharactersView) {
        self.alertView = alertView
        self.urlValidator = urlValidator
        self.getCharacters = getCharacters
        self.loadingView = loadingView
        self.characterView = characterView
    }
    
    public func requestCharacters(_ url: URL) {
        
        if urlValidator.isValid(url) {
            
            self.loadingView?.display(LoadingViewModel(isLoading: true))
            
            getCharacters.get(url: url) { [weak self] result in
                
                guard let self = self else { return }
                
                switch result {
                case .success(let data):
                    if let response = data {
                        self.characterView?.displayCharacter(CharactersViewModel(characters: response))
                    } else {
                        self.alertView?.display(AlertViewModel(title: "Sucesso", message: "Recuperou os personagens da API."))
                    }
                    
                case .failure:
                    self.alertView?.display(AlertViewModel(title: "Falhou", message: "Algo inesperado aconteceu, tente novamente mais tarde."))
                }
                self.loadingView?.display(LoadingViewModel(isLoading: false))
            }
            
        } else {
            let model = AlertViewModel(title: "Falhou", message: "URL fornecida é inválida.")
            alertView?.display(model)
        }
    }
}
