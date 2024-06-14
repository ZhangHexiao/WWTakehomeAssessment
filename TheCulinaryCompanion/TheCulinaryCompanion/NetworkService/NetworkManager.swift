//
//  NetworkManager.swift
//  TheCulinaryCompanion
//
//  Created by Rodney Zhang on 2024-06-13.
//

import Foundation

public enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
}

public class NetworkManager {
    
    static let shared = NetworkManager()
    private var baseUrl = ""
    private let session = URLSession(configuration: .default)
    
    public func executeRequest(url: String,
                               method: HTTPMethod,
                               parameters: [String: String]? = nil,
                               headers: [String: String]? = nil,
                               completion: @escaping (Result<Any, Error>) -> ()) {
        
        var urlString = "\(baseUrl)\(url)"
        
        var jsonData: Data?
        if let parameters = parameters {
            switch method {
            case .get where !parameters.isEmpty:
                urlString = urlString + "?" + query(parameters)
            case .post, .put, .patch, .delete:
                jsonData = try? JSONSerialization.data(withJSONObject: parameters as Any, options: [])
            default: break
            }
        }
        
        guard let url = URL(string: urlString) else {
            let error = URLError(URLError.unsupportedURL)
            return completion(.failure(error))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let httpHeaders = headers {
            for (key, value) in httpHeaders {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        request.httpBody = jsonData
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            self?.requestCompletionHandler(data, response, error, completion: completion)
        }
        task.resume()
    }
    
    private func requestCompletionHandler(_ data: Data?, _ response: URLResponse?, _ error: Error?, completion: @escaping (Result<Any, Error>) -> ()) {
        if let err = error {
            completion(.failure(NetworkError.errorFromResponse))
            return
        }
        
        guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else{
            completion(.failure(NetworkError.invalidStatusCode))
            return
        }
        
        if let validData = data {
            do {
                let responseObject = try JSONSerialization.jsonObject(with: validData, options: .mutableContainers)
                completion(.success(responseObject))
            } catch {
                completion(.failure(NetworkError.jsonSerializationError))
            }
        } else {
            completion(.failure(NetworkError.invalidData))
        }
        
    }
}

extension NetworkManager {
    public func query(_ parameters: [String: String]) -> String {
        var components: [(String, String)] = []
        
        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components.append((key, value))
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
}
