//
//  SearchSearchInitializer.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import UIKit

class SearchModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var searchViewController: SearchViewController!

    override func awakeFromNib() {

        let configurator = SearchModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: searchViewController)
    }

}
