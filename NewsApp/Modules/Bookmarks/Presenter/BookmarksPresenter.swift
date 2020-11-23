//
//  BookmarksBookmarksPresenter.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

class BookmarksPresenter: BookmarksModuleInput, BookmarksViewOutput, BookmarksInteractorOutput {
    weak var view: BookmarksViewInput!
    var interactor: BookmarksInteractorInput!
    var router: BookmarksRouterInput!

    func viewIsReady() {
    }
}
