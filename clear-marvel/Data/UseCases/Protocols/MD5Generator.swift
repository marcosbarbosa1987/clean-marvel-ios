//
//  MD5Generator.swift
//  Data
//
//  Created by Marcos Barbosa on 17/10/21.
//

import Foundation
import CommonCrypto

public protocol MD5Generator {
    func generateHash(from timestamp: Int64, and privateKey: String, and publicKey: String ) -> String
}

extension MD5Generator {
    
    public func MD5(from string: String) -> String {
        let lenght = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: lenght)
        
        if let d = string.data(using: String.Encoding.utf8) {
            _ = d.withUnsafeBytes({ (body: UnsafePointer<UInt8>) in
                CC_MD5(body, CC_LONG(d.count), &digest)
            })
        }
        
        return (0..<lenght).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
}
