//
//  RemoteGetCharactersTests.swift
//  DataTests
//
//  Created by Marcos Barbosa on 16/10/21.
//

import XCTest
import Data
import CommonCrypto

class RemoteGetCharactersTests: XCTestCase {
    
    func test_get_should_call_httpClient_with_correct_url() {
        let url = URL(string: "http://any-url.com")!
        let httpGetRequestSpy = HttpGetRequestSpy()
        let sut = RemoteGetCharacters(url: url, httpGetRequest: httpGetRequestSpy)
        sut.get()
        XCTAssertEqual(httpGetRequestSpy.url, url)
    }
    
    func test_get_should_call_httpClient_with_incorrect_url() {
        let url = URL(string: "http://any-url.com")!
        let httpGetRequestSpy = HttpGetRequestSpy()
        let sut = RemoteGetCharacters(url: URL(string: "http://another-url.com")!, httpGetRequest: httpGetRequestSpy)
        sut.get()
        XCTAssertNotEqual(httpGetRequestSpy.url, url)
    }
}

class HttpGetRequestSpy: HttpGetRequest {
    
    var url: URL?
    
    func get(from url: URL, completion: @escaping (Result<Data?, Error>) -> Void) {
        self.url = url
    }
}


