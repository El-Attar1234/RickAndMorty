//
//  DATA.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 10/03/2025.
//
import Foundation
import Networking
import Data

class CharactersFetcher {
    private let networkService: NetworkService = DefaultNetworkService(
        config: NetworkConfiguration(
            baseURL: AppConfigurations.baseURL,
            defaultHeaders: ["Content-Type": "application/json",
                             "Accept": "application/json"]
        )
    )
    
//    init(networkService: NetworkService = DefaultNetworkService()) {
//        self.networkService = networkService
//    }
    
    func fetchCharacters() async throws -> CharactersDTO {
        let endpoint = CharactersEndpoints.getCharacters(status: "dead", page: 1)
        let response: CharactersDTO = try await networkService.request(endpoint)
        return response
    }
}


//public struct APIEndpoints {
//    public static func getCharacters(page: Int) -> Endpoint<CharactersDTO> {
//        Endpoint(
//            path: "/character",
//            method: .get,
//            queryParameters: ["page": "\(page)"]
//        )
//    }
//
//}
//
//public struct CharactersDTO: Codable{
//    public let info: CharactersPageInfoDTO?
//    public let results: [CharacterDTO]
//}
//
//public struct CharactersPageInfoDTO: Codable {
//    public let count, pages: Int?
//    public let next: String?
//    public let prev: String?
//}
//
//public struct CharacterDTO: Codable, Identifiable{
//    public let id: Int?
//    public let name: String?
//    public let status: CharacterStatus?
//    public let species: String?
//    public let type: String?
//    public let gender: String?
//    public let origin, location: Location?
//    public let image: String?
//    public let episode: [String]?
//    public let url: String?
//    public let created: String?
//}
//
//extension CharacterDTO: Equatable {
//        public static func == (lhs: CharacterDTO, rhs: CharacterDTO) -> Bool {
//        lhs.id == rhs.id
//    }
//}
//
//public struct Location: Codable {
//    public let name: String?
//    public let url: String?
//}
//
//public enum CharacterStatus: String, Codable {
//    case alive = "Alive"
//    case dead = "Dead"
//    case unknown = "unknown"
//}
//
