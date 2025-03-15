//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 13/03/2025.
//
import Domain
import Foundation

protocol CharactersViewModel: ObservableObject {
    var pageState: ScreenState { get }
    var characters: [CharacterPresentationModel] { get }
    var selectedCharacterStatus: CharacterStatus? { get set }
    var isLoadingMore: Bool { get }
    
    func fetchCharacters()
    func applyFilter()
    func loadMoreCharacters()
    func viewOnDisappear()
    func itemSelected(with character: CharacterPresentationModel)
}

final class DefaultCharactersViewModel: CharactersViewModel {
    
    var pageState: ScreenState = .loading
    private(set) var characters = [CharacterPresentationModel]()
    
    @Published var selectedCharacterStatus: CharacterStatus?
    private var fetchedTask: Task<Void, Error>?
    
    // ``` Pagination```
    private var currentPage = 1
    var totalPages = 1
    var isLoadingMore = false
    
    private let charactersUseCase: CharactersUseCase
    private weak var delegate: CharactersDelegate?
    
    init(
        charactersUseCase: CharactersUseCase,
        delegate: CharactersDelegate?,
        selectedCharacterStatus: CharacterStatus? = nil
    ) {
        self.charactersUseCase = charactersUseCase
        self.delegate = delegate
        self.selectedCharacterStatus = selectedCharacterStatus
        
        fetchCharacters()
    }
    
    func applyFilter() {
        currentPage = 1
        characters.removeAll()
        pageState = .loading
        reloadView()
        fetchCharacters()
    }
    
    func loadMoreCharacters() {
        guard currentPage < totalPages else { return }
        currentPage += 1
        isLoadingMore = true
        reloadView()
        fetchCharacters()
    }
    
    func viewOnDisappear() {
        fetchedTask?.cancel()
        fetchedTask = nil
    }
    
    func fetchCharacters() {
        
        fetchedTask = Task(priority: .background) {
            
            do {
                let characters = try await charactersUseCase.execute(
                    for: selectedCharacterStatus?.rawValue,
                    page: currentPage
                )
                handleSuccessResponse(characters: characters)
                reloadView()
                
            } catch {
                pageState = .error
                isLoadingMore = false
                reloadView()
            }
        }
    }
    
    private func handleSuccessResponse(characters: CharactersEntity) {
        totalPages = characters.totalPages
        self.characters.append(contentsOf: characters.results.map(CharacterPresentationModel.init))
        pageState = .success
        isLoadingMore = false
    }
    
    private func reloadView() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.objectWillChange.send()
        }
    }
    
    func itemSelected(with character: CharacterPresentationModel) {
        delegate?.openCharacterDetails(with: character)
    }
}
