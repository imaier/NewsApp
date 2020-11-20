//
//  ReadReadPresenter.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//
import Foundation

class ReadPresenter: ReadModuleInput, ReadViewOutput, ReadInteractorOutput {

    weak var view: ReadViewInput!
    var interactor: ReadInteractorInput!
    var router: ReadRouterInput!

    var inputModel: News?

    func viewIsReady() {
        if let model = inputModel {
            view.update(with: model)
        }
    }

    func moduleConfiguration(with model: News) {
        inputModel = model
    }

    func getUrl(_ url:String, complition:@escaping (_ url: String, _ data: Data?) -> Void) {
        interactor.getUrl(url, complition: complition)
    }
}
