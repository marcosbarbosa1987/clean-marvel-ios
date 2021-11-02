//
//  HomePresenterTests.swift
//  PresentationTests
//
//  Created by Marcos Barbosa on 31/10/21.
//

import XCTest
import Presentation
import Domain
import Data

class HomePresenterTests: XCTestCase {

    func test_get_should_show_error_with_invalid_url() {
        let url = URL(string: "wrong-url.com")!
        let alertViewSpy = AlertViewSpy()
        let urlValidator = URLValidatorSpy()
        urlValidator.simulate()
        let sut = makeSUT(url: url, alertViewSpy: alertViewSpy, urlValidatorSpy: urlValidator)
        sut.requestCharacters()
        XCTAssertFalse(urlValidator.isValid)
        XCTAssertEqual(alertViewSpy.model, AlertViewModel(title: "Falhou", message: "URL fornecida é inválida."))
    }
    
    func test_get_should_call_getCharacters_method_with_error() {
        let alertViewSpy = AlertViewSpy()
        let getCharacterSpy = GetCharacterSpy()
        let sut = makeSUT(alertViewSpy: alertViewSpy, getCharacterSpy: getCharacterSpy)
        sut.requestCharacters()
        getCharacterSpy.completeWithError(.unexpected)
        XCTAssertEqual(alertViewSpy.model, AlertViewModel(title: "Falhou", message: "Algo inesperado aconteceu, tente novamente mais tarde."))
    }
}

extension HomePresenterTests {
    
    func makeSUT(url: URL = URL(string: "http://any-url.com")!,
                 alertViewSpy: AlertViewSpy = AlertViewSpy(),
                 urlValidatorSpy: URLValidatorSpy = URLValidatorSpy(),
                 getCharacterSpy: GetCharacterSpy = GetCharacterSpy()) -> HomePresenter {
        return HomePresenter(url: url, alertView: alertViewSpy, urlValidator: urlValidatorSpy, getCharacters: getCharacterSpy)
    }
    
    class AlertViewSpy: AlertView {
        
        var model: AlertViewModel?
        
        func display(_ model: AlertViewModel) {
            self.model = model
        }
    }
    
    class URLValidatorSpy: URLValidator {
        
        var isValid = true
        var url: URL?
        
        func isValid(_ url: URL) -> Bool {
            self.url = url
            return isValid
        }
        
        func simulate() {
            self.isValid = false
        }
    }
    
    class GetCharacterSpy: GetCharacters {
        
        var url: URL?
        var completion: ((Result<[CharacterModel?]?, Error>) -> Void)?
        
        func get(url: URL, completion: @escaping (Result<[CharacterModel?]?, Error>) -> Void) {
            self.url = url
            self.completion = completion
        }
        
        func completeWithError(_ error: DomainError) {
            completion?(.failure(error))
        }
    }
}

