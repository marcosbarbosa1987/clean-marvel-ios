//
//  LoadingView.swift
//  Presentation
//
//  Created by Marcos Barbosa on 02/11/21.
//

import Foundation

public protocol LoadingView: AnyObject {
    func display(_ viewModel: LoadingViewModel)
}

public struct LoadingViewModel: Equatable {
    public var isLoading: Bool
    
    public init(isLoading: Bool) {
        self.isLoading = isLoading
    }
}
