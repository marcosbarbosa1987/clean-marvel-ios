//
//  TestFactories.swift
//  DataTests
//
//  Created by Marcos Barbosa on 24/10/21.
//

import Foundation
import Domain

func makeURL() -> URL {
    return URL(string: "http://any-url.com")!
}

func makeError() -> Error {
    return NSError(domain: "any-error", code: 0)
}

func makeTimestamp() -> Int64 {
    return Date().currentTimeMillis()
}

func makeInvalidData() -> Data {
    return Data("invalid".utf8)
}

func makeValidData() -> Data {
    return Data("{\"name\":\"Marcos\"}".utf8)
}

func makeEmptyData() -> Data {
    return Data()
}

func makeHttpResponse(statusCode: Int = 200) -> HTTPURLResponse {
    return HTTPURLResponse(url: makeURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}

func makeCharacterModel() -> CharacterModel {
    let data = CharacterModel(data: [])
    return data
}
