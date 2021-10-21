//
//  AlamofireAdapterTest.swift
//  InfraTests
//
//  Created by Marcos Barbosa on 19/10/21.
//

import XCTest
import Data
import Alamofire

class AlamofireAdapterTest: XCTestCase {
    
    func test_() {
        let url = URL(string: "http://any-url.com")!
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration: configuration)
        let sut = AlamofireAdapter(session: session)
        sut.get(from: url)
        let exp = expectation(description: "waiting")
        UrlProtocolStub.observerRequest { (request) in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual(HTTPMethod(rawValue: "GET"), request.method)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}


class AlamofireAdapter {
    
    private let session: Session
    
    init(session: Session = Session.default) {
        self.session = session
    }
    
    func get(from url: URL) {
        session.request(url, method: .get).resume()
    }
}

class UrlProtocolStub: URLProtocol {
    
    static var emit: ((URLRequest) -> Void)?
    
    static func observerRequest(completion: @escaping(URLRequest) -> Void) {
        UrlProtocolStub.emit = completion
    }
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        UrlProtocolStub.emit?(request)
    }
    
    override func stopLoading() {}
    
}
