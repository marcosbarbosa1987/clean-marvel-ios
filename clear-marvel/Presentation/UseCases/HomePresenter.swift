//
//  HomePresenter.swift
//  Presentation
//
//  Created by Marcos Barbosa on 01/11/21.
//

import Foundation
import Domain

public class HomePresenter {
    
    private let url: URL
    private let alertView: AlertView
    private let urlValidator: URLValidator
    private let getCharacters: GetCharacters
    private let loadingView: LoadingView
    
    public init(url: URL, alertView: AlertView, urlValidator: URLValidator, getCharacters: GetCharacters, loadingView: LoadingView) {
        self.url = url
        self.alertView = alertView
        self.urlValidator = urlValidator
        self.getCharacters = getCharacters
        self.loadingView = loadingView
    }
    
    public func requestCharacters() {
        
        if urlValidator.isValid(url) {
            
            self.loadingView.display(LoadingViewModel(isLoading: true))
            
            getCharacters.get(url: url) { [weak self] result in
                
                guard let self = self else { return }
                
                switch result {
                case .success:
                    self.alertView.display(AlertViewModel(title: "Sucesso", message: "Recuperou os personagens da API."))
                    
                case .failure:
                    self.alertView.display(AlertViewModel(title: "Falhou", message: "Algo inesperado aconteceu, tente novamente mais tarde."))
                }
                self.loadingView.display(LoadingViewModel(isLoading: false))
            }
            
        } else {
            let model = AlertViewModel(title: "Falhou", message: "URL fornecida é inválida.")
            alertView.display(model)
        }
    }
}
