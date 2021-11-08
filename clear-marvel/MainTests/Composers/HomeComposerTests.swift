//
//  HomeComposerTests.swift
//  MainTests
//
//  Created by Marcos Barbosa on 06/11/21.
//

import XCTest
import Main
import UI
import Infra

class HomeComposerTests: XCTestCase {

    func test_background_request_should_complete_on_main_thread() {
        let exp = expectation(description: "description")
        let (sut, getCharacterSpy) = makeSUT()
        sut.loadViewIfNeeded()
        sut.requestCharacters?()
        DispatchQueue.global().async {
            getCharacterSpy.completeWithError(.unexpected)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}

extension HomeComposerTests {
    func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: HomeViewController, getCharacterSpy: GetCharacterSpy){
        let getCharacterSpy = GetCharacterSpy()
        let sut = HomeComposer.composeControllerWith(url: makeURL(), getCharacter: MainQueueDispatchDecorator(getCharacterSpy))
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: getCharacterSpy, file: file, line: line)
        return (sut, getCharacterSpy)
    }
}
