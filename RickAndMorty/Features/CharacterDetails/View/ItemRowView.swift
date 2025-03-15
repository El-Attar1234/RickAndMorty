//
//  ItemRowView.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 14/03/2025.
//

import SwiftUI

struct ItemRowView: View {
    
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
                .frame(width: 100, alignment: .leading)
            
            Text(value)
                .font(.body)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
