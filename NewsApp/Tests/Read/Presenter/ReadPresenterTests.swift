//
//  ReadReadPresenterTests.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import XCTest

class ReadPresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: ReadInteractorInput {

    }

    class MockRouter: ReadRouterInput {

    }

    class MockViewController: ReadViewInput {

        func setupInitialState() {

        }
    }
}
