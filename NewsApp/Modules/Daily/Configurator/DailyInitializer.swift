//
//  DailyDailyInitializer.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import UIKit

class DailyModuleInitializer: NSObject {
    //Connect with object on storyboard
    @IBOutlet private weak var dailyViewController: DailyViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        let configurator = DailyModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: dailyViewController)
    }
}
