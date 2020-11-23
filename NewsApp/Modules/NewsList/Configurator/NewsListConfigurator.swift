//
//  NewsListNewsListConfigurator.swift
//  NewsApp
//
//  Created by Ilya Maier on 16/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import UIKit

class NewsListModuleConfigurator {
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? NewsListViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: NewsListViewController) {
        let router = NewsListRouter()
        router.transitionHandler = viewController

        let presenter = NewsListPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = NewsListInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }
}
