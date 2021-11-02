//
//  Date+Extensions.swift
//  Data
//
//  Created by Marcos Barbosa on 17/10/21.
//

import Foundation

extension Date {
    public func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
