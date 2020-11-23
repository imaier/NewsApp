//
//  BookmarksBookmarksViewController.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import UIKit

class BookmarksViewController: UIViewController, BookmarksViewInput {
    var output: BookmarksViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    // MARK: BookmarksViewInput
    func setupInitialState() {
    }
}
