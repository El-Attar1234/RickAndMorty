//
//  CharactersDTO.swift
//  Data
//
//  Created by Mahmoud Elattar on 11/03/2025.
//
import Domain

public struct CharactersDTO: Codable {
    public let info: CharactersPageInfoDTO?
    public let results: [CharacterDTO]
    
    public func toDomain() -> CharactersEntity {
        CharactersEntity(
            totalPages: info?.pages ?? 0,
            results: results.map { $0.toDomain() }
        )
    }
    
}
