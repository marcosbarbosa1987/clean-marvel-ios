//
//  AlertViewSpy.swift
//  PresentationTests
//
//  Created by Marcos Barbosa on 02/11/21.
//

import Foundation
import Presentation

class AlertViewSpy: AlertView {
    var emit: ((AlertViewModel) -> Void)?
    
    func observe(completion: @escaping(AlertViewModel) -> Void) {
        self.emit = completion
    }
    
    func display(_ model: AlertViewModel) {
        self.emit?(model)
    }
}
