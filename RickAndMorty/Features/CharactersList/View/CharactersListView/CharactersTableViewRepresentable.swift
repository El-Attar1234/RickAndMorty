//
//  CharactersTableViewRepresentable.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 14/03/2025.
//
import SwiftUI

struct CharactersTableViewRepresentable<ViewModel: CharactersViewModel>: UIViewControllerRepresentable {
    @ObservedObject var viewModel: ViewModel
    
    func makeUIViewController(context: Context) -> CharactersTableViewController<ViewModel> {
        let controller = CharactersTableViewController(viewModel: viewModel)
        return controller
    }
    
    func updateUIViewController(
        _ uiViewController: CharactersTableViewController<ViewModel>,
        context: Context
    ) {
        DispatchQueue.main.async {
            if uiViewController.view.window != nil {
                uiViewController.update(with: viewModel)
            }
        }
    }
}
