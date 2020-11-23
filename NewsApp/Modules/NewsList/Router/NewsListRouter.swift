//
//  NewsListNewsListRouter.swift
//  NewsApp
//
//  Created by Ilya Maier on 16/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//
import LiteRoute

class NewsListRouter: NewsListRouterInput {
    var transitionHandler: TransitionHandler!

    func detailsButtonTapped(withNews model: News) {
        try? transitionHandler
            .forSegue(identifier: "ReadDetails", to: ReadModuleInput.self)
            .then({ moduleInput in
                moduleInput.moduleConfiguration(with: model)
            })
    }
}
