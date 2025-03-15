//
//  CharactersDelegate.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 14/03/2025.
//

protocol CharactersDelegate: AnyObject {
    
    func openCharacterDetails(with character: CharacterPresentationModel)
}
