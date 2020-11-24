//
//  NewsResponse.swift
//  NewsApp
//
//  Created by Ilya Maier on 24.11.2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import Foundation

struct NewsResponse: Codable {
    var status: String
    var totalResults: Int
    var articles: [News]
}
