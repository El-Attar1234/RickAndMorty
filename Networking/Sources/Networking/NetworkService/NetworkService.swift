//
//  NetworkService.swift
//  Networking
//
//  Created by Mahmoud Elattar on 10/03/2025.
//
//
import Foundation

public protocol NetworkService {
    func request<T: Decodable>(_ endpoint: any Requestable) async throws -> T
}

public final class DefaultNetworkService: NetworkService {
   
    private let sessionManager: NetworkSessionManager
    private let config: NetworkConfiguration

    public init(
        sessionManager: NetworkSessionManager = DefaultNetworkSessionManager(),
        config: NetworkConfiguration
    ) {
        self.sessionManager = sessionManager
        self.config = config
    }

    public func request<T: Decodable>(_ endpoint: any Requestable) async throws -> T {
        do {
            let urlRequest = try endpoint.configureURLRequest(with: config)
            let result = try await request(with: urlRequest)
            return try JSONDecoder().decode(T.self, from: result)
        } catch let error as NetworkError {
            throw error
        }
    }

    private func request(with request: URLRequest) async throws -> Data {
        do {
            let (data, response) = try await sessionManager.request(request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.badStatusCode((response as? HTTPURLResponse)?.statusCode ?? 0)
            }
            
            return data
        } catch let error as NetworkError {
            throw error
        } catch let error as DecodingError {
            throw NetworkError.decodingError(error)
        } catch {
            throw NetworkError.networkFailure(error)
        }
    }
}
