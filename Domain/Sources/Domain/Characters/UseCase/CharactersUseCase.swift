//
//  CharactersUseCase.swift
//  Domain
//
//  Created by Mahmoud Elattar on 11/03/2025.
//

public protocol CharactersUseCase {
    func execute(
        for status: String?,
        page: Int
    ) async throws -> CharactersEntity
}

public final class DefaultLCharactersUseCase: CharactersUseCase {
    
    private let repository: CharactersRepository
    
    
    public init(repository: CharactersRepository) {
        self.repository = repository
    }
    
    public func execute(
        for status: String?,
        page: Int
    ) async throws -> CharactersEntity {
        try await repository
            .fetchCharacters(
                for: status,
                page: page
            )
    }
}
