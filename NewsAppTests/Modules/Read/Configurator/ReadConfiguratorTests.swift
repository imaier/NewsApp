//
//  ReadReadConfiguratorTests.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//
import NewsApp
import XCTest

class ReadModuleConfiguratorTests: XCTestCase {
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
        let viewController = ReadViewControllerMock()
        let configurator = ReadModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "ReadViewController is nil after configuration")
        XCTAssertTrue(viewController.output is ReadPresenter, "output is not ReadPresenter")

        // swiftlint:disable:next force_cast
        let presenter: ReadPresenter = viewController.output as! ReadPresenter
        XCTAssertNotNil(presenter.view, "view in ReadPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in ReadPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is ReadRouter, "router is not ReadRouter")

        // swiftlint:disable:next force_cast
        let interactor: ReadInteractor = presenter.interactor as! ReadInteractor
        XCTAssertNotNil(interactor.output, "output in ReadInteractor is nil after configuration")
    }

    class ReadViewControllerMock: ReadViewController {
        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
