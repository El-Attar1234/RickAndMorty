//
//  SceneDelegate.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 10/03/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private var appCoordinator: Coordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        appCoordinator = AppFlowCoordinator(
            window: window,
            appDependencyProvider: DefaultAppDependencyProvider(),
            appNavigationController: UINavigationController()
        )
        appCoordinator?.start()
    }
}
