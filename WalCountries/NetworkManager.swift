//
//  CountryService.swift
//  WalCountries
//
//  Created by Dancilia Harmon   on 3/14/25.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(endpoint: String, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkManager: NetworkServiceProtocol {
    
    func fetch<T: Decodable>(endpoint: String, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
         
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(responseType, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(NetworkError.decodingError(error)))
            }
        }
        task.resume()
    }
}
        
// MARK: Custom Errors

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError(let error):
            return "Failed to decode JSON: \(error.localizedDescription)"
        }
    }
}
