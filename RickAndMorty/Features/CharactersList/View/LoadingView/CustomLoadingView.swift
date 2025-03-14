//
//  CustomLoadingView.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 13/03/2025.
//
import SwiftUI

struct CustomLoadingView: View {
    
    var body: some View {
        ProgressView()
            .scaleEffect(1.5, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
            .frame(width: 114, height: 114)
            .background(Color(.gray))
            .cornerRadius(8)
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .center
            )
    }
}
