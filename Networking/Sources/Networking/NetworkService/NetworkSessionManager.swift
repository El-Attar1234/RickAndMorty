//
//  NetworkSessionManager.swift
//  Networking
//
//  Created by Mahmoud Elattar on 10/03/2025.
//
import Foundation

public protocol NetworkSessionManager {
    func request(_ request: URLRequest) async throws -> (Data, URLResponse)
}

public final class DefaultNetworkSessionManager: NetworkSessionManager {
    
    public init() { }
    
    public func request(_ request: URLRequest) async throws -> (Data, URLResponse) {
        return try await URLSession.shared.data(for: request)
    }
}
