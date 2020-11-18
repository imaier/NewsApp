//
//  NewsListNewsListInteractorOutput.swift
//  NewsApp
//
//  Created by Ilya Maier on 16/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import Foundation

protocol NewsListInteractorOutput: class {
    func dataChanged(_ articles:[News])
}
