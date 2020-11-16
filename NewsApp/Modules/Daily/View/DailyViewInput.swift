//
//  DailyDailyViewInput.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

protocol DailyViewInput: class {

    /**
        @author Ilya Maier
        Setup initial state of the view
    */

    func setupInitialState()
    func setViewModel(forSections sections:[NewsSectionViewModel])
}
