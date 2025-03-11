//
//  CharactersRepository.swift
//  Domain
//
//  Created by Mahmoud Elattar on 11/03/2025.
//

public protocol CharactersRepository {
    func fetchCharacters(
        for status: String?,
        page: Int
    ) async throws -> CharactersEntity
}
