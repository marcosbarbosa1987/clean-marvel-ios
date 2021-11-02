//
//  UrlCreatorTest.swift
//  DataTests
//
//  Created by Marcos Barbosa on 16/10/21.
//

import XCTest
import Data

class UrlCreatorTest: XCTestCase {
    
    func test_baseUrl_endpoint_privateKey_publicKey_isNotEmpty() {
        let sut = makeSUT(model: makeModel())
        XCTAssertFalse(sut.baseURL.isEmpty)
        XCTAssertFalse(sut.privateKey.isEmpty)
        XCTAssertFalse(sut.publicKey.isEmpty)
        XCTAssertFalse(sut.endpoint.rawValue.isEmpty)
    }
    
    func test_url_creator_success_with_correct_endpoint() {
        let endpoint = UrlCreatorEndpoint.comics
        let sut = makeSUT(model: makeModel(endpoint: endpoint))
        XCTAssertEqual(sut.endpoint, endpoint)
    }
    
    func test_url_creator_fail_with_incorrect_endpoint() {
        let endpoint = UrlCreatorEndpoint.comics
        let sut = makeSUT(model: makeModel(endpoint: .characters))
        XCTAssertNotEqual(sut.endpoint, endpoint)
    }
    
    func test_url_creator_success_with_correct_baseUrl() {
        let baseUrl = "http://any-url.com"
        let sut = makeSUT(model: makeModel(baseUrl: baseUrl))
        XCTAssertEqual(sut.baseURL, baseUrl)
    }
    
    func test_url_creator_fails_with_incorrect_baseUrl() {
        let baseUrl = "http://any-url.com"
        let sut = makeSUT(model: makeModel(baseUrl: "http://another-url.com"))
        XCTAssertNotEqual(sut.baseURL, baseUrl)
    }
    
    func test_url_creator_success_with_correct_privateKey() {
        let key = "any-private-key"
        let sut = makeSUT(model: makeModel(privateKey: key))
        XCTAssertEqual(sut.privateKey, key)
    }
    
    func test_url_creator_fails_with_incorrect_privateKey() {
        let key = "any-private-key"
        let sut = makeSUT(model: makeModel(privateKey: "another-private-key"))
        XCTAssertNotEqual(sut.privateKey, key)
    }
    
    func test_url_creator_success_with_correct_publicKey() {
        let key = "any-public-key"
        let sut = makeSUT(model: makeModel(publicKey: key))
        XCTAssertEqual(sut.publicKey, key)
    }
    
    func test_url_creator_fails_with_incorrect_publicKey() {
        let key = "any-public-key"
        let sut = makeSUT(model: makeModel(publicKey: "another-public-key"))
        XCTAssertNotEqual(sut.publicKey, key)
    }
    
    func test_url_creator_success_with_correct_timestamp() {
        let timestamp = makeTimestamp()
        let sut = makeSUT(model: makeModel(timestamp: timestamp))
        XCTAssertEqual(sut.timestamp, timestamp)
    }
    
    func test_url_creator_fails_with_incorrect_timestamp() {
        let timestamp = makeTimestamp()
        let sut = makeSUT(model: makeModel(timestamp: Int64()))
        XCTAssertNotEqual(sut.timestamp, timestamp)
    }
    
    func test_url_creator_checks_if_createUrl_return_nil() {
        let sut = makeSUT(model: makeModel(endpoint: .invalid))
        XCTAssertNil(sut.getUrl())
    }
    
    func test_url_creator_checks_if_createUrl_return_Url() {
        let sut = makeSUT(model: makeModel(endpoint: .characters))
        let response = sut.getUrl()
        XCTAssertNotNil(response)
    }
}

// MARK: - Helpers

extension UrlCreatorTest {
    func makeSUT(model: UrlCreatorModel, md5GeneratorSpy: MD5Generator = MD5GeneratorSpy()) -> UrlCreator {
        return UrlCreator(model: model, md5Generator: md5GeneratorSpy)
    }
    
    func makeModel(baseUrl: String = "http://any-url.com",
                   endpoint: UrlCreatorEndpoint = .comics,
                   privateKey: String = "any-private-key",
                   publicKey: String = "any-public-key",
                   timestamp: Int64 = Int64()) -> UrlCreatorModel {
        return UrlCreatorModel(baseURL: baseUrl, endpoint: endpoint, privateKey: privateKey, publicKey: publicKey, timestamp: timestamp)
    }
}

class MD5GeneratorSpy: MD5Generator {
    
    var timestamp: Int64?
    var privateKey: String?
    var publicKey: String?
    
    func generateHash(from timestamp: Int64, and privateKey: String, and publicKey: String) -> String {
        
        self.timestamp = timestamp
        self.privateKey = privateKey
        self.publicKey = publicKey
        
        return MD5(from: "\(timestamp)\(privateKey)\(publicKey)")
    }
}

