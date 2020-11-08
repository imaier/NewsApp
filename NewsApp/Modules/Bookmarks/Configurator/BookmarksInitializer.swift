//
//  BookmarksBookmarksInitializer.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import UIKit

class BookmarksModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var bookmarksViewController: BookmarksViewController!

    override func awakeFromNib() {

        let configurator = BookmarksModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: bookmarksViewController)
    }

}
