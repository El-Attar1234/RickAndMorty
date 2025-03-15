//
//  CharacterDTO.swift
//  Data
//
//  Created by Mahmoud Elattar on 11/03/2025.
//
import Domain

public struct CharacterDTO: Codable {
    public let id: Int?
    public let name: String?
    public let status: String?
    public let species: String?
    public let type: String?
    public let gender: String?
    public let image: String?
    public let episode: [String]?
    public let url: String?
    public let created: String?
    public let location: LocationDTO?
    
    public func toDomain() -> CharacterEntity {
        CharacterEntity(
            id: id ?? 0,
            name: name ?? "",
            image: image ?? "",
            status: status ?? "",
            species: species ?? "",
            gender: gender ?? "",
            location: location?.name ?? ""
        )
    }
}
