//
//  DailyDailyInteractorOutput.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import Foundation

protocol DailyInteractorOutput: AnyObject {
    func topStoriesDataChanged(_ articles: [News])
    func latestNewsDataChanged(_ articles: [News])
}
