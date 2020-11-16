//
//  News.swift
//  TopNews
//
//  Created by Ilya Maier on 28.10.2020.
//  Copyright © 2020 mera. All rights reserved.
//

import Foundation

struct News {
    var newsSource = NewsSource(id: nil, name: "")
    var urlToImage = ""
    var title = ""
    var url = ""
    var description = ""
    var author = ""
    var publishedAt = ""
    var content = ""
    var inBoookmarks = false
}
