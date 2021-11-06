//
//  Xibed.swift
//  UI
//
//  Created by Marcos Barbosa on 06/11/21.
//

import Foundation
import UIKit

public protocol Xibed {
    static func instantiate() -> Self
}

extension Xibed where Self: UIViewController {
    
    public static func instantiate() -> Self {
        let vcName = String(describing: self)
        let bundle = Bundle(for: Self.self)
        return Self(nibName: vcName, bundle: bundle) as! Self
    }
    
}
//let controller = HomeViewController(nibName: "HomeViewController", bundle: Bundle(for: HomeViewController.self))
