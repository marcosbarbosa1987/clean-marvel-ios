//
//  HomeComposer.swift
//  Main
//
//  Created by Marcos Barbosa on 06/11/21.
//

import Foundation
import Domain
import UI

public final class HomeComposer {
    
    public static func composeControllerWith(url: URL, getCharacter: GetCharacters) -> HomeViewController {
        return ControllerFactory.makeHome(url: url, getCharacter: getCharacter)
    }
}
