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
        let exp = expectation(description: "waiting")
        let url = URL(string: "wrong-url.com")!
        let alertViewSpy = AlertViewSpy()
        let urlValidator = URLValidatorSpy()
        urlValidator.simulate()
        let sut = makeSUT(url: url, alertViewSpy: alertViewSpy, urlValidatorSpy: urlValidator)
        
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falhou", message: "URL fornecida é inválida."))
            exp.fulfill()
        }
        
        sut.requestCharacters()
        XCTAssertFalse(urlValidator.isValid)
        wait(for: [exp], timeout: 1)
    }
    
    func test_get_should_call_getCharacters_method_with_error() {
        let exp = expectation(description: "waiting")
        let alertViewSpy = AlertViewSpy()
        let getCharacterSpy = GetCharacterSpy()
        let sut = makeSUT(alertViewSpy: alertViewSpy, getCharacterSpy: getCharacterSpy)
        
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falhou", message: "Algo inesperado aconteceu, tente novamente mais tarde."))
            exp.fulfill()
        }
        
        sut.requestCharacters()
        getCharacterSpy.completeWithError(.unexpected)
        wait(for: [exp], timeout: 1)
    }
    
    func test_get_should_call_getCharacters_method_with_success() {
        let exp = expectation(description: "waiting")
        let alertViewSpy = AlertViewSpy()
        let getCharacterSpy = GetCharacterSpy()
        let sut = makeSUT(alertViewSpy: alertViewSpy, getCharacterSpy: getCharacterSpy)
        
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Sucesso", message: "Recuperou os personagens da API."))
            exp.fulfill()
        }
        
        sut.requestCharacters()
        getCharacterSpy.completeWithSuccess(makeCharacterModel())
        wait(for: [exp], timeout: 1)
    }
    
    func test_get_should_call_loading_before_and_after_call_getCharacters() {
        
        let loadingViewSpy = LoadingViewSpy()
        let getCharacterSpy = GetCharacterSpy()
        let sut = makeSUT(getCharacterSpy: getCharacterSpy, loadingViewSpy: loadingViewSpy)
        
        let exp = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
            exp.fulfill()
        }
        
        sut.requestCharacters()
        wait(for: [exp], timeout: 1)
        
        let exp2 = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
            exp2.fulfill()
        }
        getCharacterSpy.completeWithError(.unexpected)
        wait(for: [exp2], timeout: 1)
    }
}

extension HomePresenterTests {
    
    func makeSUT(url: URL = makeURL(),
                 alertViewSpy: AlertViewSpy = AlertViewSpy(),
                 urlValidatorSpy: URLValidatorSpy = URLValidatorSpy(),
                 getCharacterSpy: GetCharacterSpy = GetCharacterSpy(),
                 loadingViewSpy: LoadingViewSpy = LoadingViewSpy(),
                 file: StaticString = #file, line: UInt = #line) -> HomePresenter {
        
        let sut = HomePresenter(url: url, alertView: alertViewSpy, urlValidator: urlValidatorSpy, getCharacters: getCharacterSpy, loadingView: loadingViewSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
    }

    class GetCharacterSpy: GetCharacters {
        
        var url: URL?
        var completion: ((Result<CharacterModel?, Error>) -> Void)?
        
        func get(url: URL, completion: @escaping (Result<CharacterModel?, Error>) -> Void) {
            self.url = url
            self.completion = completion
        }
        
        func completeWithError(_ error: DomainError) {
            completion?(.failure(error))
        }
        
        func completeWithSuccess(_ data: CharacterModel) {
            completion?(.success(data))
        }
    }
}

