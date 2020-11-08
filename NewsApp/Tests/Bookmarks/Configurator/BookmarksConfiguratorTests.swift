//
//  BookmarksBookmarksConfiguratorTests.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import XCTest

class BookmarksModuleConfiguratorTests: XCTestCase {

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
        let viewController = BookmarksViewControllerMock()
        let configurator = BookmarksModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "BookmarksViewController is nil after configuration")
        XCTAssertTrue(viewController.output is BookmarksPresenter, "output is not BookmarksPresenter")

        let presenter: BookmarksPresenter = viewController.output as! BookmarksPresenter
        XCTAssertNotNil(presenter.view, "view in BookmarksPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in BookmarksPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is BookmarksRouter, "router is not BookmarksRouter")

        let interactor: BookmarksInteractor = presenter.interactor as! BookmarksInteractor
        XCTAssertNotNil(interactor.output, "output in BookmarksInteractor is nil after configuration")
    }

    class BookmarksViewControllerMock: BookmarksViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
