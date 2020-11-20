//
//  ReadReadRouter.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//
import UIKit
import LiteRoute

class ReadRouter: ReadRouterInput {
    var transitionHandler: TransitionHandler!

    func share(with model: News) {
        guard let url = URL(string: model.url) else {
            return
        }
        let items = [url]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        if let viewController = transitionHandler as? UIViewController {
            viewController.present(activityVC, animated: true)
        }
    }
}
