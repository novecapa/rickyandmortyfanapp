//
//  MainViewModel.swift
//  RickyAndMortyFanTests
//
//  Created by Josep Cerdà Penadés on 24/1/23.
//

import XCTest
@testable import RickyAndMortyFan

class MainViewModelTests: XCTestCase {

    let nameTest: String = "morty"
    let pageTest: Int = 1
    var model: MainViewModel!
    var router: MainRouter!
    var repo: CharacterRepositoryMock!
    var useCase: CharacterUseCaseProtocol!

    override func setUp() {
        router = MainRouter(viewController: nil)
        let characterRepo = CharacterRepositoryMock()
        useCase = CharacterUseCase(repository: characterRepo)
        model = MainViewModel(router: router,
                              characterUseCase: useCase)
    }

    override func tearDown() {
        model = nil
        router = nil
        repo = nil
        useCase = nil
    }

    func testViewModelIsNotNil() {
        XCTAssertNotNil(model)
    }
    func testViewReady() {
        XCTAssertNotNil(model.viewReady)
        model.viewReady()
    }
    func testViewDidAppear() {
        XCTAssertNotNil(model.viewDidAppear)
        model.viewDidAppear()
    }
    func testResetPagination() {
        XCTAssertNotNil(model.resetPagination)
        model.resetPagination()
    }

    func testFetchCharacters() {
        Task {
            let repoC = CharacterRepositoryMock()
            let useCaseC = CharacterUseCase(repository: repoC)
            let characterList = try await useCaseC.getCharacterList(page: pageTest)
            XCTAssertFalse(characterList.0.isEmpty)
        }
    }

    func testFilterCharacters() {
        Task {
            let repoC = CharacterRepositoryMock()
            let useCaseC = CharacterUseCase(repository: repoC)
            let characterList = try await useCaseC.filterCharacter(name: nameTest,
                                                                   page: pageTest)
            XCTAssertFalse(characterList.0.isEmpty)
        }
    }
}
