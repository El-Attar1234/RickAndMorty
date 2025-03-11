//
//  CharactersEndpoints.swift
//  Data
//
//  Created by Mahmoud Elattar on 11/03/2025.
//
import Networking

public struct CharactersEndpoints {
    
    public static func getCharacters(status: String?, page: Int) -> Endpoint<CharactersDTO> {
        
        var queryParameters = ["page": "\(page)", "limit": "20"]
        
        if let status {
            queryParameters["status"] = status
        }
        
        return  Endpoint(
            path: "/character",
            method: .get,
            queryParameters: queryParameters
        )
    }
}
