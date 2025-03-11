//
//  NetworkConfiguration.swift
//  Networking
//
//  Created by Mahmoud Elattar on 10/03/2025.
//
import Foundation

public struct NetworkConfiguration {
    public let baseURL: URL
    public let defaultHeaders: [String: String]
    
    public init(
        baseURL: URL,
        defaultHeaders: [String: String] = [:]
    ) {
        self.baseURL = baseURL
        self.defaultHeaders = defaultHeaders
    }
}
