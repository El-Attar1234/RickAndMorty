//
//  NetworkError.swift
//  Networking
//
//  Created by Mahmoud Elattar on 10/03/2025.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL
    case networkFailure(Error)
    case invalidResponse
    case decodingError(Error)
    case badStatusCode(Int)
}
