//
//  NewsListNewsListInitializer.swift
//  NewsApp
//
//  Created by Ilya Maier on 16/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import UIKit

class NewsListModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var newslistViewController: NewsListViewController!

    override func awakeFromNib() {

        let configurator = NewsListModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: newslistViewController)
    }

}
