//
//  ReadReadModuleInput.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

protocol ReadModuleInput: AnyObject {
    func moduleConfiguration(with model: News)
}
