//
//  HomeViewControllerTests.swift
//  UITests
//
//  Created by Marcos Barbosa on 02/11/21.
//

import XCTest
import Presentation
@testable import UI

class HomeViewControllerTests: XCTestCase {
    
    func test_loading_is_hidden_on_start() {
        let sut = makeSUT()
        XCTAssertEqual(sut.loadingIndicator.isAnimating, false)
    }
    
    func test_sut_implements_loadingView() {
        XCTAssertNotNil(makeSUT() as LoadingView)
    }
    
    func test_sut_implements_alertView() {
        XCTAssertNotNil(makeSUT() as AlertView)
    }
    
    func test_tableView_starts_with_zero_row() {
        let sut = makeSUT()
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_tableview_reload_with_one_row() {
        let sut = makeSUT()
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
}

extension HomeViewControllerTests {
    
    func makeSUT() -> HomeViewController {
        let sut = HomeViewController(nibName: "HomeViewController", bundle: Bundle(for: HomeViewController.self))
        sut.loadViewIfNeeded()
        return sut
    }
    
    
    
    
}



