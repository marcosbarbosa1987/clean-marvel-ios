//
//  HomeIntegrationTests.swift
//  MainTests
//
//  Created by Marcos Barbosa on 06/11/21.
//

import XCTest
import Main

class HomeIntegrationTests: XCTestCase {

    func test_ui_presentation_integration() {
        let sut = HomeComposer.composeControllerWith(url: makeURL(), getCharacter: GetCharacterSpy())
        checkMemoryLeak(for: sut)
    }
}
