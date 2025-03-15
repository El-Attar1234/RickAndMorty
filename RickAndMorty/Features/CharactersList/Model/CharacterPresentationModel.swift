//
//  CharacterPresentationModel.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 13/03/2025.
//
import Domain

struct CharacterPresentationModel {
    let id: Int
    let name: String
    let image: String
    let status: CharacterStatus
    let species: String
    let gender: String
    let location: String
    
    init(character: CharacterEntity) {
        self.id = character.id
        self.name = character.name
        self.image = character.image
        self.status = CharacterStatus(rawValue: character.status) ?? .unknown
        self.species = character.species
        self.gender = character.gender
        self.location = character.location
    }
}
