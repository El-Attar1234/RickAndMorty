//
//  DefaultCharactersRepository.swift
//  Data
//
//  Created by Mahmoud Elattar on 11/03/2025.
//
import Domain
import Networking

public final class DefaultCharactersRepository: CharactersRepository {
    
    private let remoteDataSource: NetworkService
    
    // MARK: - Life cycle
    public init(remoteDataSource: NetworkService) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func fetchCharacters(
        for status: String?,
        page: Int
    ) async throws -> CharactersEntity {
        let charactersEndPoint = CharactersEndpoints.getCharacters(
            status: status,
            page: page
        )
        let response: CharactersDTO = try await remoteDataSource.request(charactersEndPoint)
        return response.toDomain()
    }
}
