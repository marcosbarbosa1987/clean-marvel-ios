//
//  RemoteGetCharactersTests.swift
//  DataTests
//
//  Created by Marcos Barbosa on 16/10/21.
//

import XCTest
import Data
import Domain
import CommonCrypto

class RemoteGetCharactersTests: XCTestCase {
    
    func test_get_should_call_httpClient_with_correct_url() {
        let url = makeURL()
        let (sut, _) = makeSUT()
        sut.get() { _ in }
        XCTAssertEqual(sut.url, url)
    }
    
    func test_get_should_call_httpClient_completes_with_error() {
        let (sut, httpRequestSpy) = makeSUT()
        expect(sut, completeWith: .failure(.unexpected)) {
            httpRequestSpy.completeWithError(.noConnectivity)
        }
    }
    
    func test_get_should_call_httpClient_completes_with_data() {
        
        let (sut, httpRequestSpy) = makeSUT()
        let expectedData = makeCharacterModel()
        expect(sut, completeWith: .success(makeCharacterModel())) {
            httpRequestSpy.completeWithData(expectedData.toData()!)
        }
    }
    
    func test_get_should_call_httpClient_completes_with_invalidData() {
        
        let (sut, httpRequestSpy) = makeSUT()
        expect(sut, completeWith: .failure(.unexpected)) {
            httpRequestSpy.completeWithData(makeInvalidData())
        }
    }
    
    func test_get_should_call_httpClient_not_complete_if_sut_is_null() {
        var (sut, httpRequestSpy): (RemoteGetCharacters?, HttpRequestSpy) = makeSUT()
        var result: Result<CharacterModel?, DomainError>?
        sut?.get() { result = $0}
        sut = nil
        httpRequestSpy.completeWithError(.noConnectivity)
        XCTAssertNil(result)
    }
    
}

extension RemoteGetCharactersTests {
    
    func makeSUT(url: URL = URL(string: "http://any-url.com")!, file: StaticString = #file, line: UInt = #line) -> (sut: RemoteGetCharacters, httpRequestSpy: HttpRequestSpy) {
        let httpRequestSpy = HttpRequestSpy()
        let sut = RemoteGetCharacters(url: url, httpGetRequest: httpRequestSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpRequestSpy, file: file, line: line)
        return (sut, httpRequestSpy)
    }
    
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
    }
    
    func expect(_ sut: RemoteGetCharacters, completeWith expectedResult: Result<CharacterModel, DomainError>, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "waiting")
        sut.get() { receivedResult in
            switch (expectedResult, receivedResult) {
            
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError, file: file, line: line)
                
            case (.success(let expectedData), .success(let receivedData)):
                XCTAssertEqual(expectedData, receivedData, file: file, line: line)
                
            default:
                XCTFail("Expected \(expectedResult)error received \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
    
    class HttpRequestSpy: HttpGetRequest {
        
        var urls: [URL] = []
        var completion: ((Result<Data?, HttpError>) -> Void)?
        
        func get(from url: URL, completion: @escaping (Result<Data?, HttpError>) -> Void) {
            self.urls.append(url)
            self.completion = completion
        }
        
        func completeWithError(_ error: HttpError) {
            completion?(.failure(error))
        }
        
        func completeWithData(_ data: Data) {
            completion?(.success(data))
        }
    }
}



