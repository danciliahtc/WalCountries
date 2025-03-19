//
//  MockNetworkManager.swift
//  WalCountriesTests
//
//  Created by Dancilia Harmon   on 3/19/25.
//

import Foundation
@testable import WalCountries

class MockNetworkManager: NetworkServiceProtocol {
    var shouldReturnError = false
    var shouldReturnDecodingError = false
    
    func fetch<T: Decodable>(endpoint: String, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
            if self.shouldReturnError {
                completion(.failure(NetworkError.invalidURL))
            } else if self.shouldReturnDecodingError {
                let invalidJsonData = """
                {"invalid": "data"}
                """.data(using: .utf8)!
                
                do {
                    let _ = try JSONDecoder().decode(responseType, from: invalidJsonData)
                    completion(.success([] as! T))
                } catch {
                    completion(.failure(NetworkError.decodingError(error)))
                    }
            } else {
                let validJsonData = """
                [
                    {"name": "United States", "region": "NA", "code": "US", "capital": "Washington, D.C."},
                    {"name": "Canada", "region": "NA", "code": "CA", "capital": "Ottawa"}
                ]
                """.data(using: .utf8)!
                
                do {
                    let decodedData = try JSONDecoder().decode(responseType, from: validJsonData)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(NetworkError.decodingError(error)))
                }
            }
        }
    }
}
