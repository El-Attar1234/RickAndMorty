//
//  DefaultCharactersViewModelTests.swift
//  RickAndMortyTests
//
//  Created by Mahmoud Elattar on 14/03/2025.
//
@testable import RickAndMorty
import XCTest
import Domain

final class DefaultCharactersViewModelTests: XCTestCase {
    
    var viewModel: DefaultCharactersViewModel!
    var mockUseCase: MockCharactersUseCase!
    var mockDelegate: MockCharactersDelegate!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockUseCase = MockCharactersUseCase()
        mockDelegate = MockCharactersDelegate()
        viewModel = DefaultCharactersViewModel(
            charactersUseCase: mockUseCase,
            delegate: mockDelegate
        )
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockUseCase = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    func testInitialFetchCharactersSuccess() async {
        // Arrange
        let characters = getMockCharacters()
        mockUseCase.update(mockCharacters: characters)
        
        // Act
        viewModel.fetchCharacters()
        await waitForExpectation(description: "Fetch characters for success")
        
        // Assert
        XCTAssertEqual(viewModel.pageState, .success)
    }
    
    func testFetchCharactersFailure() async {
        // Arrange
        mockUseCase.update(shouldReturnError: true)
        
        // Act
        viewModel.fetchCharacters()
        await waitForExpectation(description: "Fetch characters for failure")
        
        // Then
        XCTAssertEqual(viewModel.pageState, .error)
    }
    
    func testApplyFilters() async {
        // Arrange
        let characters = getMockCharacters()
        mockUseCase.update(mockCharacters: characters)
        
        // Act
        viewModel.fetchCharacters()
        await waitForExpectation(description: "Fetch characters for apply filter")
        viewModel.selectedCharacterStatus = .alive
        viewModel.applyFilter()
        await waitForExpectation(description: "Apply Filter")
        
        // Assert
        XCTAssertEqual(viewModel.characters.count, 1)
    }
    
    func testLoadMoreCharacters() async {
        // Arrange
        let characters = getMockCharacters()
        mockUseCase.update(mockCharacters: characters)
        
        // Act
        viewModel.fetchCharacters()
        await waitForExpectation(description: "Fetch characters for pagination")
        let initialCharactersCount = viewModel.characters.count
        
        viewModel.loadMoreCharacters()
        await waitForExpectation(description: "Pagination")
        let finalCharactersCount = viewModel.characters.count
        
        // Assert
        XCTAssertGreaterThan(finalCharactersCount, initialCharactersCount)
    }
    
    func testItemSelectedCallsDelegate() {
        // Arrange
        let character = CharacterPresentationModel(character: getMockCharacters()[0])
        
        // Act
        viewModel.itemSelected(with: character)
        
        // Assert
        XCTAssertEqual(mockDelegate.selectedCharacter?.id, character.id)
    }
    

    private func getMockCharacters() -> [CharacterEntity] {
        let firstCharacter = CharacterEntity(
            id: 1,
            name: "Mahmoud Elattar",
            image: "",
            status: "Alive",
            species: "Human",
            gender: "Male",
            location: "Egypt"
        )
        
        return [firstCharacter]
    }
    
    private func waitForExpectation(description: String) async {
        let expectation = XCTestExpectation(description: description)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if self.viewModel.pageState != .loading {
                expectation.fulfill()
            }
        }
        await fulfillment(of: [expectation], timeout: 1.5)
    }
}
