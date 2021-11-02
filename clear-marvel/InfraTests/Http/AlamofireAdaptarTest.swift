//
//  AlamofireAdapterTest.swift
//  InfraTests
//
//  Created by Marcos Barbosa on 19/10/21.
//

import XCTest
import Infra
import Data
import Alamofire

class AlamofireAdapterTest: XCTestCase {
    
    func test_get_should_make_request_with_valid_url_and_method() {
        let url = makeURL()
        requestFrom(url: url) { (request) in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual(HTTPMethod(rawValue: "GET"), request.method)
        }
    }
    
    func test_get_should_complete_with_error_when_request_completes_with_error() {
        expectedResult(.failure(.noConnectivity), when: (data: nil, response: nil, error: makeError()))
    }
    
    func test_get_should_complete_with_data_when_request_completes_with_200() {
        expectedResult(.success(makeValidData()), when: (data: makeValidData(), response: makeHttpResponse(), error: nil))
    }
    
    func test_get_should_complete_with_no_ata_when_request_completes_with_204() {
        expectedResult(.success(nil), when: (data: nil, response: makeHttpResponse(statusCode: 204), error: nil))
        expectedResult(.success(nil), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 204), error: nil))
        expectedResult(.success(nil), when: (data: makeEmptyData(), response: makeHttpResponse(statusCode: 204), error: nil))
    }
    
    func test_get_should_complete_with_error_when_request_completes_non_400() {
        expectedResult(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 400), error: nil))
        expectedResult(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 450), error: nil))
        expectedResult(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 499), error: nil))
        expectedResult(.failure(.serverError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 500), error: nil))
        expectedResult(.failure(.serverError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 550), error: nil))
        expectedResult(.failure(.serverError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 599), error: nil))
        expectedResult(.failure(.unauthorized), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 401), error: nil))
        expectedResult(.failure(.forbidden), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 403), error: nil))
        expectedResult(.failure(.noConnectivity), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 300), error: nil))
        expectedResult(.failure(.noConnectivity), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 350), error: nil))
        expectedResult(.failure(.noConnectivity), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 399), error: nil))
    }
    
    func test_get_should_complete_with_error_on_all_invalid_cases() {
        expectedResult(.failure(.noConnectivity), when: (data: makeValidData(), response: makeHttpResponse(), error: makeError()))
        expectedResult(.failure(.noConnectivity), when: (data: makeValidData(), response: nil, error: makeError()))
        expectedResult(.failure(.noConnectivity), when: (data: makeValidData(), response: nil, error: nil))
        expectedResult(.failure(.noConnectivity), when: (data: nil, response: makeHttpResponse(), error: makeError()))
        expectedResult(.failure(.noConnectivity), when: (data: nil, response: makeHttpResponse(), error: nil))
        expectedResult(.failure(.noConnectivity), when: (data: nil, response: nil, error: nil))
    }
}


extension AlamofireAdapterTest {
    
    func makeSUT() -> AlamofireAdapter {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration: configuration)
        return AlamofireAdapter(session: session)
    }
    
    
    func requestFrom(url: URL = makeURL(), when action: @escaping(URLRequest) -> Void) {
        
        let exp = expectation(description: "waiting")
        let sut = makeSUT()
        sut.get(from: url) { _ in exp.fulfill()}
        var request: URLRequest?
        UrlProtocolStub.observerRequest { request = $0}
        wait(for: [exp], timeout: 1)
        if let req = request {
            action(req)
        }
    }
    
    func expectedResult(_ expectedResult: Result<Data?, HttpError>, when stub: (data: Data?, response: HTTPURLResponse?, error: Error?), file: StaticString = #filePath, line: UInt = #line) {
        let sut = makeSUT()
        UrlProtocolStub.simulate(data: stub.data, response: stub.response, error: stub.error)
        let exp = expectation(description: "waiting")
        
        sut.get(from: makeURL()) { receivedResult in
            
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedData), .success(let receivedData)):
                XCTAssertEqual(expectedData, receivedData, file: file, line: line)
            default:
                XCTFail("Expected \(expectedResult) error got \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
