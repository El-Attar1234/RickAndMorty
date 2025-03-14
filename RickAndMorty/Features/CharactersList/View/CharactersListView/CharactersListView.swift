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
        VStack(alignment: .leading, spacing: 8) {
            
            headerTitleView
            
            filtersView
            
            switch viewModel.pageState {
            case .loading:
                CustomLoadingView()
                
            case .success:
                CharactersTableViewRepresentable(viewModel: viewModel)
                
                if viewModel.isLoadingMore {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
            case .error:
                errorView
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .onDisappear {
            viewModel.viewOnDisappear()
        }
    }
    
    private var headerTitleView: some View {
        Text("Characters")
            .font(.largeTitle)
            .fontWeight(.bold)
    }
    
    private var filtersView: some View {
        FiltersView(selectedStatus: $viewModel.selectedCharacterStatus)
            .padding(.vertical, 8)
            .onChange(of: viewModel.selectedCharacterStatus) {
                viewModel.applyFilter()
            }
            .disabled(viewModel.pageState != .success)
    }
    
    private var errorView: some View {
        VStack(spacing: 12) {
            Text("Something Went Wrong!")
            FilterButton(
                title: "Try Again" ,
                isSelected: true) {
                    viewModel.fetchCharacters()
                }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .center
        )
        
    }
}
