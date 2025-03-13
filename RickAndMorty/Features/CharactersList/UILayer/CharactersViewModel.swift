//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 13/03/2025.
//
import Domain
import Foundation

enum ScreenState {
    case loading
    case error
    case success
}

protocol CharactersViewModel: ObservableObject {
    var pageState: ScreenState { get }
    var characters: [CharacterPresentationModel] { get }
    var selectedCharacterStatus: CharacterStatus? { get set }
    
    func fetchCharacters()
    func applyFilter()
    func loadMoreCharacters()
}

final class DefaultCharactersViewModel: CharactersViewModel {
    
    var pageState: ScreenState = .loading
    private(set) var characters = [CharacterPresentationModel]()
    
    @Published var selectedCharacterStatus: CharacterStatus?
    
    
    // ``` Pagination```
    private var currentPage = 1
    var totalPages = 1
    
    private let charactersUseCase: CharactersUseCase
    
    init(
        charactersUseCase: CharactersUseCase,
        selectedCharacterStatus: CharacterStatus? = nil
    ) {
        self.charactersUseCase = charactersUseCase
        self.selectedCharacterStatus = selectedCharacterStatus
        
        fetchCharacters() // ??
    }
    
    func applyFilter() {
        currentPage = 1
        characters.removeAll()
        pageState = .loading
        reloadView()
        fetchCharacters()
    }
    
    
    func loadMoreCharacters() {
        currentPage += 1
        fetchCharacters()
    }
    
    func fetchCharacters() {
        
        Task(priority: .background) {
            
            do {
                let characters = try await charactersUseCase.execute(
                    for: selectedCharacterStatus?.rawValue,
                    page: currentPage
                )
                handleSuccessResponse(characters: characters)
                reloadView() 
                
            } catch {
                //TODO: - will enhance it
                pageState = .error
            }
        }
    }
    
    private func handleSuccessResponse(characters: CharactersEntity) {
        totalPages = characters.totalPages
        self.characters.append(contentsOf: characters.results.map(CharacterPresentationModel.init))
        pageState = .success
    }
    
    private func reloadView() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.objectWillChange.send()
        }
    }
}
