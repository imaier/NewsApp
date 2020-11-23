//
//  BookmarksBookmarksConfigurator.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import UIKit

class BookmarksModuleConfigurator {
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? BookmarksViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: BookmarksViewController) {
        let router = BookmarksRouter()

        let presenter = BookmarksPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = BookmarksInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }
}
