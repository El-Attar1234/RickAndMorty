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
        await waitForExpectation(description: "Fetch characters")
        
        // Assert
        XCTAssertEqual(viewModel.pageState, .success)
        XCTAssertEqual(viewModel.characters.count, 1)
        XCTAssertEqual(viewModel.characters[safeIndex: 0]?.name, "Mahmoud Elattar")
        XCTAssertFalse(viewModel.isLoadingMore)
    }
    
    func testFetchCharactersFailure() async {
        // Arrange
        mockUseCase.update(shouldReturnError: true)
        
        // Act
        await waitForExpectation(description: "Fetch characters")
        
        // Then
        XCTAssertTrue(viewModel.characters.isEmpty)
    }
    
    func testApplyFilters() async {
        // Arrange
        let characters = getMockCharacters()
        mockUseCase.update(mockCharacters: characters)
        
        // Act
        await waitForExpectation(description: "Fetch characters")
        viewModel.selectedCharacterStatus = .alive
        viewModel.applyFilter()
        await waitForExpectation(description: "Apply Filter")
        
        // Assert
        XCTAssertEqual(viewModel.pageState, .success)
        XCTAssertEqual(viewModel.characters.count, 1)
        XCTAssertEqual(viewModel.characters[safeIndex: 0]?.name, "Mahmoud Elattar")
        XCTAssertFalse(viewModel.isLoadingMore)
        XCTAssertNotNil(viewModel.selectedCharacterStatus)
    }
    
    func testLoadMoreCharacters() async {
        // Arrange
        let characters = getMockCharacters()
        mockUseCase.update(mockCharacters: characters)
        
        // Act
        await waitForExpectation(description: "Fetch characters")
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
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 2.0)
    }
}
