//
//  NetworkManager.swift
//  booklove
//
//  Created by Moritz on 17.07.24.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    enum NetworkError: Error {
        case invalidURL
        case requestFailed
        case invalidResponse
        case decodingFailed
    }
    
    func fetch(urlString: String, method: HTTPMethod, params: [String: Any]? = nil, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if method == .POST, let params = params {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                completion(.failure(.requestFailed))
                return
            }
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(.requestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.decodingFailed))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
