//
//  MainViewController.swift
//  RickyAndMortyFanTests
//
//  Created by Josep Cerdà Penadés on 24/1/23.
//

import XCTest
@testable import RickyAndMortyFan

class MainViewControllerTests: XCTestCase {

    let test: String = "test"
    var viewController: MainViewController!
    var model: MainViewModel!
    var router: MainRouter!
    var repo: CharacterRepositoryMock!
    var useCase: CharacterUseCaseProtocol!

    override func setUp() {
        viewController = Container.shared.mainBuilder().build()
        router = MainRouter(viewController: viewController)
        let characterRepo = CharacterRepositoryMock()
        useCase = CharacterUseCase(repository: characterRepo)
        model = MainViewModel(router: router, characterUseCase: useCase)
        viewController.viewModel = model
        viewController.loadViewIfNeeded()
    }

    override func tearDown() {
        viewController = nil
        model = nil
        router = nil
        repo = nil
        useCase = nil
    }

    func testViewDidLoad() {
        XCTAssertNotNil(viewController)
        viewController.viewDidLoad()
    }

    func testViewDidAppear() {
        XCTAssertNotNil(viewController)
        viewController.viewDidAppear(true)
    }

    func testRefreshList() {
        XCTAssertNotNil(viewController.viewModel.refreshList)
        viewController.viewModel.refreshList?()
    }

    func testStartActivity() {
        XCTAssertNotNil(viewController.viewModel.startActivityIndicator)
        viewController.loadViewIfNeeded()
        _ = viewController.view
        viewController.viewModel.startActivityIndicator?()
    }

    func testStopActivity() {
        XCTAssertNotNil(viewController.viewModel.stopActivityIndicator)
        viewController.loadViewIfNeeded()
        _ = viewController.view
        viewController.viewModel.stopActivityIndicator?()
    }

    func testScrollToTop() {
        XCTAssertNotNil(viewController.viewModel.scrollToTop)
        viewController.loadViewIfNeeded()
        _ = viewController.view
        viewController.viewModel.scrollToTop?()
    }

    // MARK: - Collection View
    func testCellForRow() {
        XCTAssertNotNil(viewController)
        model.charactersList = CharacterEntityMock.getListMock()
        XCTAssertFalse(model.charactersList.isEmpty)
        let indexPath = IndexPath(item: 0, section: 0)
        _ = viewController.collectionView(viewController.collectionCharacters,
                                          cellForItemAt: indexPath)
    }

    func testDidSelectItemAt() {
        XCTAssertNotNil(viewController)
        model.charactersList = CharacterEntityMock.getListMock()
        XCTAssertFalse(model.charactersList.isEmpty)
        let indexPath = IndexPath(item: 0, section: 0)
        viewController.collectionView(viewController.collectionCharacters,
                                      didSelectItemAt: indexPath)
    }
}
