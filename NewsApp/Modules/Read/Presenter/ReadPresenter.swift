//
//  ReadReadPresenter.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

class ReadPresenter: ReadModuleInput, ReadViewOutput, ReadInteractorOutput {

    weak var view: ReadViewInput!
    var interactor: ReadInteractorInput!
    var router: ReadRouterInput!

    func viewIsReady() {

    }
}
