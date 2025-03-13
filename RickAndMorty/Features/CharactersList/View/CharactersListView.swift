//
//  CharactersListView.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 13/03/2025.
//
import SwiftUI

struct CharactersListView<ViewModel: CharactersViewModel>: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            FiltersView(selectedStatus: $viewModel.selectedCharacterStatus)
                .padding(.vertical, 8)
                .onChange(of: viewModel.selectedCharacterStatus) {
                    viewModel.applyFilter()
                }
            
            switch viewModel.pageState {
            case .loading:
                // will move it for another custom view with edit colors and constants
                ProgressView()
                    .scaleEffect(1.5, anchor: .center)
                    .progressViewStyle(CircularProgressViewStyle(tint: Color(.green)))
                    .frame(width: 114, height: 114)
                    .background(Color(.orange))
                    .cornerRadius(8)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
            case .success:
               // VStack {
                   
                    
                    CharactersTableViewRepresentable(viewModel: viewModel)
                //}
                //            CharactersTableViewRepresentable(viewModel: viewModel)
            case .error:
                Text("Error")
            }
            
            Spacer()
        }
    }
}
