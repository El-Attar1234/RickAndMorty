//
//  Requestable.swift
//  Networking
//
//  Created by Mahmoud Elattar on 10/03/2025.
//
import Foundation

public protocol Requestable {
    var path: String { get }
    var method: HTTPMethodType { get }
    var headers: [String: String]? { get }
    var queryParameters: [String: String]? { get }
    
    func configureURLRequest(with config: NetworkConfiguration) throws -> URLRequest
}
