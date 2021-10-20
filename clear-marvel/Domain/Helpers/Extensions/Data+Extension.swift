//
//  Data+Extension.swift
//  Domain
//
//  Created by Marcos Barbosa on 19/10/21.
//

import Foundation

public extension Data {
    func toModel<T: Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
}
