//
//  DailyDailyPresenter.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

class DailyPresenter: DailyModuleInput, DailyViewOutput, DailyInteractorOutput {

    weak var view: DailyViewInput!
    var interactor: DailyInteractorInput!
    var router: DailyRouterInput!

    func viewIsReady() {

    }
}
