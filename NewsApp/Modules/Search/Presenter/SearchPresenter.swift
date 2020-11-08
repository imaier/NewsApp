//
//  SearchSearchPresenter.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

class SearchPresenter: SearchModuleInput, SearchViewOutput, SearchInteractorOutput {

    weak var view: SearchViewInput!
    var interactor: SearchInteractorInput!
    var router: SearchRouterInput!

    func viewIsReady() {

    }
}
