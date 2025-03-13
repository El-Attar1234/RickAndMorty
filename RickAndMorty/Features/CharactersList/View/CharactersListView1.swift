//
//  CharactersListView1.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 10/03/2025.
//

import SwiftUI

import Domain
import Data
import Networking

struct CharactersListView1: View {
    @State var page: Int = 1
    var body: some View {
        Text("Hello, World!")
            .onTapGesture {
                page += 1
                if page == 1 || page == 3 || page == 5 || page == 7 {
                    fetchCharacters(status: "Alive")
                } else {
                    fetchCharacters(status: "Dead")
                }
                
            }
            .onAppear {
                fetchCharacters()
            }
    }
    func fetchCharacters(status: String? = nil) {
    
        Task(priority: .background) {
            let repo: CharactersRepository = DefaultCharactersRepository(remoteDataSource: DefaultNetworkService(
                config: NetworkConfiguration(
                    baseURL: AppConfigurations.baseURL,
                    defaultHeaders: ["Content-Type": "application/json",
                                     "Accept": "application/json"]
                )
            ))
            
           // let repo: CharactersRepository = DefaultCharactersRepository(remoteDataSource: remote)
            let useCase: CharactersUseCase = DefaultLCharactersUseCase(repository: repo)
            
//            let endpoint = APIEndpoints.getCharacters(page: currentPage)
            do {
                let response = try await useCase.execute(
                    for: status,
                    page: 1
                )
                print("MMMM \(response.results)")
               // print(response.)
            } catch {
                print(error)
            }
        }
    }
}
