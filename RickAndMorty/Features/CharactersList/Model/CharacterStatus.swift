//
//  CharacterStatus.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 14/03/2025.
//

enum CharacterStatus: String, CaseIterable{
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    
    var backgroundColorName: String {
        switch self {
        case .alive:
            return "alive"
        case .dead:
            return "dead"
        default:
            return "unknown"
        }
    }
}
