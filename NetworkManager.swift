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
        case requestFailed(Error)
        case invalidResponse(statusCode: Int, message: String?)
        case noData
        case decodingFailed(Error)
        case custom(message: String)
        
        var localizedDescription: String {
            switch self {
            case .invalidURL:
                return "The URL provided is invalid."
            case .requestFailed(let error):
                return "Request failed with error: \(error.localizedDescription)"
            case .invalidResponse(let statusCode, let message):
                return "Invalid response received with status code: \(statusCode). Message: \(message ?? "No additional message.")"
            case .noData:
                return "No data received from the server."
            case .decodingFailed(let error):
                return "Decoding failed with error: \(error.localizedDescription)"
            case .custom(let message):
                return message
            }
        }
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
                completion(.failure(.custom(message: "Failed to serialize parameters into JSON: \(error.localizedDescription)")))
                return
            }
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.custom(message: "The response is not an HTTP URL response.")))
                return
            }
            
            let statusCode = httpResponse.statusCode
            if !(200...299).contains(statusCode) {
                let errorMessage: String?
                if let data = data {
                    // Extract plaintext error message from response data
                    errorMessage = String(data: data, encoding: .utf8)
                } else {
                    errorMessage = nil
                }
                completion(.failure(.invalidResponse(statusCode: statusCode, message: errorMessage)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
