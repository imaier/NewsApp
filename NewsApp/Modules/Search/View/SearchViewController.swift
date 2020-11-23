//
//  SearchSearchViewController.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, SearchViewInput {
    var output: SearchViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    // MARK: SearchViewInput
    func setupInitialState() {
    }
}
