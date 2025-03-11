//
//  CharactersPageInfoDTO.swift
//  Data
//
//  Created by Mahmoud Elattar on 11/03/2025.
//

public struct CharactersPageInfoDTO: Codable {
    public let count, pages: Int?
    public let next: String?
    public let prev: String?
}
