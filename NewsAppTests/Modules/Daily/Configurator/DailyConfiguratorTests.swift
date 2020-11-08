//
//  DailyDailyConfiguratorTests.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import XCTest

class DailyModuleConfiguratorTests: XCTestCase {

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
        let viewController = DailyViewControllerMock()
        let configurator = DailyModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "DailyViewController is nil after configuration")
        XCTAssertTrue(viewController.output is DailyPresenter, "output is not DailyPresenter")

        let presenter: DailyPresenter = viewController.output as! DailyPresenter
        XCTAssertNotNil(presenter.view, "view in DailyPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in DailyPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is DailyRouter, "router is not DailyRouter")

        let interactor: DailyInteractor = presenter.interactor as! DailyInteractor
        XCTAssertNotNil(interactor.output, "output in DailyInteractor is nil after configuration")
    }

    class DailyViewControllerMock: DailyViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
