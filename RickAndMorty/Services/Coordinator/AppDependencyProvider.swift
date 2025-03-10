//
//  AppDependencyProvider.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 10/03/2025.
//

import SwiftUI

protocol AppDependencyProvider {
    func makeCharactersListViewController() -> UIHostingController<CharactersListView>
}

final class DefaultAppDependencyProvider: AppDependencyProvider {
    
    func makeCharactersListViewController() -> UIHostingController<CharactersListView> {
        return UIHostingController (rootView: CharactersListView())
    }
}
