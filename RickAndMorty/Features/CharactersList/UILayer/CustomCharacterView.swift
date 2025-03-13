//
//  CustomCharacterView.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 13/03/2025.
//
import SwiftUI

struct CustomCharacterView: View {
    let character: CharacterPresentationModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImageView(url: character.image, size: 60)
                .frame(width: 80, height: 80)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(character.name)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.primary)
                
                Text(character.status.rawValue)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                
                Text(character.species)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.all, 8)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.gray, lineWidth: 1)
        )
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .clipShape(RoundedRectangle(cornerRadius: 16))
      
    }
}
