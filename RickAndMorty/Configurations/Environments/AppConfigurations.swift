//
//  AppConfigurations.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 10/03/2025.
//
import Foundation

public enum AppConfigurations {
    
    private struct Keys {
        static let baseURL = "BASE_URL"
    }
    
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else { return ["" : ""] }
        return dict
    }()
    
    // MARK: - Plist values
    static let baseURL: URL? = {
        guard let rootURLString = infoDictionary[Keys.baseURL] as? String else { return nil }
        guard let url = URL(string: rootURLString) else { return nil }
        return url
    }()
}
