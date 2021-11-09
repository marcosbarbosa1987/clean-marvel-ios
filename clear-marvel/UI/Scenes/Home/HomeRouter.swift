//
//  HomeRouter.swift
//  UI
//
//  Created by Marcos Barbosa on 08/11/21.
//

import UIKit
import Domain

public final class HomeRouter {
    
    private let nav: NavigationController
    private let detailCharacterFactory: (CharacterResult?) -> DetailCharacterViewController
    
    public init(nav: NavigationController, detailCharacterFactory: @escaping (CharacterResult?) -> DetailCharacterViewController) {
        self.nav = nav
        self.detailCharacterFactory = detailCharacterFactory
    }
    
    public func goToDetail(item: CharacterResult?) {
        nav.pushViewController(detailCharacterFactory(item))
    }
}
