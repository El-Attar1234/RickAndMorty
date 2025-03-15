//
//  MockCharactersUseCase.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 14/03/2025.
//
import Domain
import Networking

class MockCharactersUseCase: CharactersUseCase {
    var shouldReturnError = false
    var mockCharacters: [CharacterEntity] = []
    var totalPages: Int = 3
    
    func execute(for status: String?, page: Int) async throws -> CharactersEntity {
        if shouldReturnError {
            throw NetworkError.invalidResponse
        }
        
        return CharactersEntity(
            totalPages: totalPages,
            results: mockCharacters
        )
    }
    
    func update(shouldReturnError: Bool = false,
                mockCharacters: [CharacterEntity] = [],
                totalPages: Int = 3) {
        self.shouldReturnError = shouldReturnError
        self.mockCharacters = mockCharacters
        self.totalPages = totalPages
    }
    
}
