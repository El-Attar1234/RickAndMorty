//
//  Array+Ext.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 14/03/2025.
//

extension Array {
    
    subscript(safeIndex index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
