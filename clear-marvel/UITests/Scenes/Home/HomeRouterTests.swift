//
//  HomeRouterTests.swift
//  UITests
//
//  Created by Marcos Barbosa on 08/11/21.
//

import XCTest
import UIKit
import UI
import Domain

class HomeRouterTests: XCTestCase {
    
    func test_goToDetail_calls_nav_with_correct_vc() {
        let (sut, nav) = makeSUT()
        let characterThumb = CharacterThumb(path: "jpg", extensionType: "")
        let item = CharacterResult(id: 0, name: "teste name", description: "teste description", thumbnail: characterThumb)
        sut.goToDetail(item: item)
        XCTAssertEqual(nav.viewControllers.count, 1)
        XCTAssertTrue(nav.viewControllers[0] is DetailCharacterViewController)
    }
}

extension HomeRouterTests {
    
    func makeSUT() -> (sut: HomeRouter, nav: NavigationController) {
        let nav = NavigationController()
        let detailCharacterFactorySpy = DetailCharacterFactorySpy()
        let sut = HomeRouter(nav: nav, detailCharacterFactory: detailCharacterFactorySpy.makeDetailCharacter(item:))
        return (sut, nav)
    }
}

extension HomeRouterTests {
    class DetailCharacterFactorySpy {
        func makeDetailCharacter(item: CharacterResult?) -> DetailCharacterViewController {
            let controller = DetailCharacterViewController.instantiate()
            controller.item = item
            return controller
        }
    }
}
