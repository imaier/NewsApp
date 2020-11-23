//
//  NewsListNewsListViewInput.swift
//  NewsApp
//
//  Created by Ilya Maier on 16/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

protocol NewsListViewInput: AnyObject {
    /**
        @author Ilya Maier
        Setup initial state of the view
    */

    func setupInitialState()
    func update(with model: NewsListViewModel)
}
