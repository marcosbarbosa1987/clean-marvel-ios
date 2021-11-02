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
    
    public init(url: URL, alertView: AlertView, urlValidator: URLValidator, getCharacters: GetCharacters) {
        self.url = url
        self.alertView = alertView
        self.urlValidator = urlValidator
        self.getCharacters = getCharacters
    }
    
    public func requestCharacters() {
        
        if urlValidator.isValid(url) {
            
            getCharacters.get(url: url) { result in
                switch result {
                case .success:
                    break
                    
                case .failure:
                    self.alertView.display(AlertViewModel(title: "Falhou", message: "Algo inesperado aconteceu, tente novamente mais tarde."))
                }
            }
            
        } else {
            let model = AlertViewModel(title: "Falhou", message: "URL fornecida é inválida.")
            alertView.display(model)
        }
    }
}
