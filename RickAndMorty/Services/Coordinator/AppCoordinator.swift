//
//  AppCoordinator.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 10/03/2025.
//

import SwiftUI

protocol Coordinator {
    func start()
}

final class AppFlowCoordinator: Coordinator {
    
    private let window: UIWindow?
    private let appDependencyProvider: AppDependencyProvider
    private let appNavigationController: UINavigationController
    
    init(window: UIWindow?,
         appDependencyProvider: AppDependencyProvider,
         appNavigationController: UINavigationController) {
        self.window = window
        self.appDependencyProvider = appDependencyProvider
        self.appNavigationController = appNavigationController
    }
    
    func start() {
        let charactersListView = appDependencyProvider.makeCharactersListViewController(delegate: self)
        appNavigationController.pushViewController(charactersListView, animated: true)
        window?.rootViewController = appNavigationController
        window?.makeKeyAndVisible()
    }
}

extension AppFlowCoordinator: CharactersDelegate {
    func openCharacterDetails(with character: CharacterPresentationModel) {
        let rootView = CharacterDetailsView(character: character)
        let characterDetailsVC = UIHostingController(rootView: rootView)
        appNavigationController.pushViewController(characterDetailsVC, animated: true)
    }
}
