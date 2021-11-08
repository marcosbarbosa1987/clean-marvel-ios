//
//  MainQueueDispatchDecorator.swift
//  Main
//
//  Created by Marcos Barbosa on 07/11/21.
//

import Foundation
import Domain

public final class MainQueueDispatchDecorator<T> {
    private let instance: T
    
    public init(_ instance: T) {
        self.instance = instance
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else { return DispatchQueue.main.async(execute: completion)}
        completion()
    }
}

extension MainQueueDispatchDecorator: GetCharacters where T: GetCharacters {
    public func get(url: URL, completion: @escaping (Result<CharacterModel?, DomainError>) -> Void) {
        instance.get(url: url) { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}
