//
//  AppCoordinator.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 10/03/2025.
//

import UIKit

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
        let charactersListView = appDependencyProvider.makeCharactersListViewController()
        appNavigationController.pushViewController(charactersListView, animated: true)
        window?.rootViewController = appNavigationController
        window?.makeKeyAndVisible()
    }
}
