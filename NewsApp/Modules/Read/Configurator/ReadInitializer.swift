//
//  ReadReadInitializer.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import UIKit

class ReadModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var readViewController: ReadViewController!

    override func awakeFromNib() {

        let configurator = ReadModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: readViewController)
    }

}
