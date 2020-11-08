//
//  ReadReadConfigurator.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import UIKit

class ReadModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? ReadViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: ReadViewController) {

        let router = ReadRouter()

        let presenter = ReadPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = ReadInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
