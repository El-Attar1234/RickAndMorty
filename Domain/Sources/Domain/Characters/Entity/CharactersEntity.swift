//
//  Characters.swift
//  Domain
//
//  Created by Mahmoud Elattar on 11/03/2025.
//

public struct CharactersEntity {
    public let totalPages: Int
    public let results: [CharacterEntity]
    
    public init(
        totalPages: Int,
        results: [CharacterEntity]
    ) {
        self.totalPages = totalPages
        self.results = results
    }
}

public struct CharacterEntity {
    public let id: Int
    public let name: String
    public let image: String
    public let status: String
    public let species: String
    public let gender: String
    public let location: String
    
    public init(
        id: Int,
        name: String,
        image: String,
        status: String,
        species: String,
        gender: String,
        location: String
    ) {
        self.id = id
        self.name = name
        self.image = image
        self.status = status
        self.species = species
        self.gender = gender
        self.location = location
    }
}
