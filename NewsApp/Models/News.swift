//
//  News.swift
//  TopNews
//
//  Created by Ilya Maier on 28.10.2020.
//  Copyright © 2020 mera. All rights reserved.
//

import Foundation

struct News: Codable {
    var newsSource = NewsSource(id: nil, name: "")
    var urlToImage: String?
    var title = ""
    var url = ""
    var description = ""
    var author: String?
    var publishedAt: Date
    var content: String?
    var inBoookmarks = false

    enum CodingKeys: String, CodingKey {
        case newsSource = "source"
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }
}

extension News {
    init(with newsMO: NewsMO) {
        newsSource = NewsSource(id: newsMO.sourceId, name: newsMO.sourceName ?? "")
        urlToImage = newsMO.urlToImage
        title = newsMO.title ?? ""
        url = newsMO.url ?? ""
        description = newsMO.descriptionInfo ?? ""
        author = newsMO.author
        publishedAt = newsMO.publishedAt ?? Date()
        content = newsMO.content
        inBoookmarks = newsMO.inBoookmarks
    }
}

extension NewsMO {
    func fill(with news: News, andType type: SectionType) {
        author = news.author
        content = news.content
        descriptionInfo = news.description
        inBoookmarks = news.inBoookmarks
        newsType = Int32(type.rawValue)
        publishedAt = news.publishedAt
        sourceId = news.newsSource.id
        sourceName = news.newsSource.name
        title = news.title
        url = news.url
        urlToImage = news.urlToImage
    }
}
