//
//  NewsListNewsListConfiguratorTests.swift
//  NewsApp
//
//  Created by Ilya Maier on 16/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import XCTest

class NewsListModuleConfiguratorTests: XCTestCase {

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
        let viewController = NewsListViewControllerMock()
        let configurator = NewsListModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "NewsListViewController is nil after configuration")
        XCTAssertTrue(viewController.output is NewsListPresenter, "output is not NewsListPresenter")

        let presenter: NewsListPresenter = viewController.output as! NewsListPresenter
        XCTAssertNotNil(presenter.view, "view in NewsListPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in NewsListPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is NewsListRouter, "router is not NewsListRouter")

        let interactor: NewsListInteractor = presenter.interactor as! NewsListInteractor
        XCTAssertNotNil(interactor.output, "output in NewsListInteractor is nil after configuration")
    }

    class NewsListViewControllerMock: NewsListViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
