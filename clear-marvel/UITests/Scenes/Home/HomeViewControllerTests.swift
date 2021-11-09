//
//  HomeViewControllerTests.swift
//  UITests
//
//  Created by Marcos Barbosa on 02/11/21.
//

import XCTest
import Presentation
import Domain
@testable import UI

class HomeViewControllerTests: XCTestCase {
    
    func test_loading_is_hidden_on_start() {
        let (sut, _) = makeSUT()
        XCTAssertEqual(sut.loadingIndicator.isAnimating, false)
    }
    
    func test_sut_implements_loadingView() {
        let (sut, _) = makeSUT()
        XCTAssertNotNil(sut as LoadingView)
    }
    
    func test_sut_implements_alertView() {
        let (sut, _) = makeSUT()
        XCTAssertNotNil(sut as AlertView)
    }
    
    func test_sut_implements_characterView() {
        let (sut, _) = makeSUT()
        XCTAssertNotNil(sut as CharactersView)
    }
    
    func test_tableView_starts_with_zero_row() {
        let (sut, _) = makeSUT()
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
        
        sut.characters = makeValidCharacters()
        sut.tableView.reloadData()
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_tableView_not_appear_select_row() {
        let (sut, _) = makeSUT()
        XCTAssertFalse(sut.tableView.allowsMultipleSelection)
    }
    
    func test_tableView_separatorStyle_is_none() {
        let (sut, _) = makeSUT()
        XCTAssertEqual(sut.tableView.separatorStyle, .none)
    }
    
    func test_tableViewCell_click_redirect_to_detail_scene() {
        let (sut, clickSpy) = makeSUT()
        let characterModel = makeValidCharacters()
        let firstItem = characterModel.characters.data?.results?.first
        sut.characters = characterModel
        sut.tableView.reloadData()
        let indexPath = IndexPath(row: 0, section: 0)
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: indexPath)
        XCTAssertEqual(sut.itemSelected, firstItem)
        XCTAssertEqual(clickSpy.click, 1)
    }
}

extension HomeViewControllerTests {
    
    func makeValidCharacters() -> CharactersViewModel {
        let characterThumb = CharacterThumb(path: "jpg", extensionType: "")
        let results = CharacterResult(id: 0, name: "teste name", description: "teste description", thumbnail: characterThumb)
        let characterData = CharacterData(offSet: 0, total: 0, results: [results])
        let characterModel = CharacterModel(data: characterData)
        return CharactersViewModel(characters: characterModel)
    }
    
    func makeSUT() -> (sut: HomeViewController, clickSpy: ClickSpy) {
        let sut = HomeViewController.instantiate()
        let clickSpy = ClickSpy()
        sut.selectedItem = clickSpy.onClick
        sut.loadViewIfNeeded()
        return (sut, clickSpy)
    }
    
    class ClickSpy {
        var click = 0
        
        func onClick(item: CharacterResult?) {
            click += 1
        }
    }
}



