//
//  NetworkManager.swift
//  Venues
//
//  Created by Enas Ahmed Zaki on 25/05/2022.
//

import Foundation

class NetworkManager {
    
    // Generic function to get data from API using Get method
    class func get<T: Codable>(requestURL: URL, headers: [String: String], mapTo: T.Type, completion: @escaping (Result<T, Error>) -> ()){
        
        var urlRequest = URLRequest.init(url: requestURL)
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                completion(.failure(NetworkError.networkError))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let results = try decoder.decode(T.self, from: data)
                print(results)
                
                completion(.success(results))
            } catch {
                completion(.failure(NetworkError.noData))
            }
            
        }.resume()
    }
}
