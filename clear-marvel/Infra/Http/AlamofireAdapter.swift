//
//  AlamofireAdapter.swift
//  Infra
//
//  Created by Marcos Barbosa on 24/10/21.
//

import Foundation
import Alamofire
import Data

public final class AlamofireAdapter: HttpGetRequest {
    
    private let session: Session
    
    public init(session: Session = Session.default) {
        self.session = session
    }
    
    public func get(from url: URL, completion: @escaping(Result<Data?, HttpError>) -> Void) {
        
        session.request(url, method: .get, encoding: JSONEncoding.default).responseData { dataResponse in
            
            guard let statusCode = dataResponse.response?.statusCode else {
                return completion(.failure(.noConnectivity))
            }
            
            switch dataResponse.result {
            case .failure:
                completion(.failure(.noConnectivity))
                
                print(statusCode)
                
            case .success(let data):
                
                switch statusCode {
                case 204:
                    completion(.success(nil))
                case 200...299:
                    completion(.success(data))
                case 401:
                    completion(.failure(.unauthorized))
                case 403:
                    completion(.failure(.forbidden))
                case 400...499:
                    completion(.failure(.badRequest))
                case 500...599:
                    completion(.failure(.serverError))
                default:
                    completion(.failure(.noConnectivity))
                }
            }
        }
    }
}
