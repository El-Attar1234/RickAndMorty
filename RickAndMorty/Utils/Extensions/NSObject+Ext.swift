//
//  NSObject+Ext.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 14/03/2025.
//

import Foundation

public protocol ClassNameProtocol {
    static var className: String { get }
}

extension NSObject: ClassNameProtocol {}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }
}
