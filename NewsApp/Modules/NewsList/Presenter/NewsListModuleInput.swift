//
//  NewsListNewsListModuleInput.swift
//  NewsApp
//
//  Created by Ilya Maier on 16/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

protocol NewsListModuleInput: AnyObject {
    func moduleConfiguration(with type: SectionType)
}
