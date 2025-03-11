//
//  Endpoint.swift
//  Networking
//
//  Created by Mahmoud Elattar on 10/03/2025.
//

import Foundation

public struct Endpoint<T: Decodable>: Requestable {
    
    public let path: String
    public let method: HTTPMethodType
    public let headers: [String: String]?
    public let queryParameters: [String: String]?
    
    public init(
        path: String,
        method: HTTPMethodType,
        headers: [String: String]? = nil,
        queryParameters: [String: String]? = nil
    ) {
        self.path = path
        self.method = method
        self.headers = headers
        self.queryParameters = queryParameters
    }
    
    public func configureURLRequest(with config: NetworkConfiguration) throws -> URLRequest {
        let url = try self.configureURL(with: config)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        // Merge default headers with endpoint-specific headers
        var allHeaders = config.defaultHeaders
        headers?.forEach { allHeaders[$0.key] = $0.value }
        urlRequest.allHTTPHeaderFields = allHeaders
        
        return urlRequest
    }
    
    private func configureURL(with config: NetworkConfiguration) throws -> URL {
        var components = URLComponents(
            url: config.baseURL.appendingPathComponent(path),
            resolvingAgainstBaseURL: false
        )
        
        if let queryParams = queryParameters, !queryParams.isEmpty {
            components?.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        
        return url
    }
}
