//
//  ServiceProvider.swift
//  DataWowChallenge
//
//  Created by Chace Teera on 13/5/2567 BE.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case decodingError
    case networkError(Error)
    case unknown
}

class ServiceProvider {
    func request<T: Decodable>(router: Router, responseType: T.Type, completion: @escaping (Result<Response<T>, NetworkError>) -> Void) {
        var request = URLRequest(url: router.url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(Response<T>.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
