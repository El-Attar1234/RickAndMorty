//
//  MockCharactersDelegate.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 14/03/2025.
//
@testable import RickAndMorty

class MockCharactersDelegate: CharactersDelegate {
    var selectedCharacter: CharacterPresentationModel?
    
    func openCharacterDetails(with character: CharacterPresentationModel) {
        selectedCharacter = character
    }
}
