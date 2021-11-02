//
//  LoadingViewSpy.swift
//  PresentationTests
//
//  Created by Marcos Barbosa on 02/11/21.
//

import Foundation
import Presentation

class LoadingViewSpy: LoadingView {
    
    var emit: ((LoadingViewModel) -> Void)?
    
    func observe(completion: @escaping(LoadingViewModel) -> Void) {
        self.emit = completion
    }
    
    func display(_ viewModel: LoadingViewModel) {
        self.emit?(viewModel)
    }
}
