//
//  SearchSearchConfiguratorTests.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import XCTest

class SearchModuleConfiguratorTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigureModuleForViewController() {
        //given
        let viewController = SearchViewControllerMock()
        let configurator = SearchModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "SearchViewController is nil after configuration")
        XCTAssertTrue(viewController.output is SearchPresenter, "output is not SearchPresenter")

        // swiftlint:disable:next force_cast
        let presenter: SearchPresenter = viewController.output as! SearchPresenter
        XCTAssertNotNil(presenter.view, "view in SearchPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in SearchPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is SearchRouter, "router is not SearchRouter")

        // swiftlint:disable:next force_cast
        let interactor: SearchInteractor = presenter.interactor as! SearchInteractor
        XCTAssertNotNil(interactor.output, "output in SearchInteractor is nil after configuration")
    }

    class SearchViewControllerMock: SearchViewController {
        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
