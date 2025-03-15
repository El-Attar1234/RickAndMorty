//
//  CharacterDetailsView.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 14/03/2025.
//

import SwiftUI

struct CharacterDetailsView: View {
    let character: CharacterPresentationModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
            ZStack(alignment: .top) {
                ScrollView {
                    VStack(spacing: 12) {
                        headerView
                        
                        infoCardView
                            .padding(.horizontal, 16)
                    }
                }
                customBackButton
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
    
    private var headerView: some View {
        VStack(alignment: .leading, spacing: 30) {
            AsyncImageView(url: character.image)
                .frame(maxWidth: .infinity)
                .frame(height: 350)
                .shadow(radius: 5)
            
            Text(character.name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
        }
    }
    
    private var infoCardView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 16) {
                ItemRowView(title: "Species", value: character.species)
                ItemRowView(title: "Gender", value: character.gender)
                ItemRowView(title: "Location", value: character.location)
            }
            
            Spacer()
            
            Text(character.status.rawValue)
                .font(.headline)
                .padding(8)
                .background(Color(character.status.backgroundColorName))
                .cornerRadius(8)
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(radius: 3)
        )
    }
    
    private var customBackButton: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(12)
                    .background(
                        Circle()
                            .fill(Color.black.opacity(0.6))
                    )
            }
            .padding(.top, 45)
            .padding(.leading, 16)
            
            Spacer()
        }
    }
}
