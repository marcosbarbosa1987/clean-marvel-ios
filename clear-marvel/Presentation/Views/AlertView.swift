//
//  AlertView.swift
//  Presentation
//
//  Created by Marcos Barbosa on 01/11/21.
//

import Foundation

public protocol AlertView {
    func display(_ viewModel: AlertViewModel)
}

public struct AlertViewModel: Equatable {
    public var title: String
    public var message: String
    
    public init(title: String, message: String) {
        self.title = title
        self.message = message
    }
}
