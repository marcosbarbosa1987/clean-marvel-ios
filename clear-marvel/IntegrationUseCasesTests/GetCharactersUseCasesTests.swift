//
//  GetCharactersUseCasesTests.swift
//  IntegrationUseCasesTests
//
//  Created by Marcos Barbosa on 31/10/21.
//

import XCTest
import Data
import Infra
import Alamofire

class GetCharactersUseCasesTests: XCTestCase {

    func test_get_characters() {
        let exp = expectation(description: "waiting")
        let url = URL(string: "http://gateway.marvel.com/v1/public/characters?ts=1622767434656&apikey=e635872de001202b9ede79b944413bdd&hash=81fed372878a81470c0750f7d244dccc")!
        let alamofireAdapter = AlamofireAdapter()
        let sut = RemoteGetCharacters(url: url, httpGetRequest: alamofireAdapter)
        sut.get(url: url) { result in
            switch result {
            case .failure:
                XCTFail("Expect success got \(result) instead")
                
            case .success(let data):
                XCTAssertNotNil(data)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
}
