//
//  DailyDailyRouter.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//
import LiteRoute

class DailyRouter: DailyRouterInput {

    var transitionHandler: TransitionHandler!

    func sectionButtonTapped(withType type: SectionType) {
        try? transitionHandler
            .forSegue(identifier: "SectionDetails", to: NewsListModuleInput.self)
            .then { moduleInput in
                moduleInput.moduleConfiguration(with: type)
            }
    }

    func detailsButtonTapped(withNews model: News) {
        try? transitionHandler
            .forSegue(identifier: "ReadDetails", to: ReadModuleInput.self)
            .then({ moduleInput in
                moduleInput.moduleConfiguration(with: model)
            })
    }
}
