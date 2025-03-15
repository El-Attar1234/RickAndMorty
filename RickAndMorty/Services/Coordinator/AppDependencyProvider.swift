//
//  AppDependencyProvider.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 10/03/2025.
//

import SwiftUI
import Networking
import Domain
import Data

protocol AppDependencyProvider {
    func makeCharactersListViewController(delegate: CharactersDelegate?) -> UIHostingController<CharactersListView<DefaultCharactersViewModel>>
}

final class DefaultAppDependencyProvider: AppDependencyProvider {
    
    private lazy var networkConfiguration: NetworkConfiguration = {
        NetworkConfiguration(
            baseURL: AppConfigurations.baseURL,
            defaultHeaders: ["Content-Type": "application/json",
                             "Accept": "application/json"]
        )
    }()
    
    func makeCharactersListViewController(delegate: CharactersDelegate?) -> UIHostingController<CharactersListView<DefaultCharactersViewModel>> {
        let charactersViewModel = DefaultCharactersViewModel(
            charactersUseCase: makeCharactersUseCase(),
            delegate: delegate
        )
        return UIHostingController (rootView: CharactersListView(viewModel: charactersViewModel))
    }
    
    private func makeCharactersUseCase() -> CharactersUseCase {
        DefaultLCharactersUseCase(repository: makeCharactersRepository())
    }
    
    private func makeCharactersRepository() -> CharactersRepository {
        DefaultCharactersRepository(remoteDataSource: makeCharactersRemoteDataSource())
    }
    
    private func makeCharactersRemoteDataSource() -> NetworkService {
        DefaultNetworkService(config: networkConfiguration)
    }
}
