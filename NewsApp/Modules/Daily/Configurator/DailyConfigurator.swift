//
//  DailyDailyConfigurator.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import UIKit

class DailyModuleConfigurator {
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? DailyViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: DailyViewController) {
        let router = DailyRouter()
        router.transitionHandler = viewController

        let presenter = DailyPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = DailyInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }
}
