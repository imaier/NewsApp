//
//  NewsListNewsListInteractor.swift
//  NewsApp
//
//  Created by Ilya Maier on 16/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//
import Foundation

class NewsListInteractor: NewsListInteractorInput {
    weak var output: NewsListInteractorOutput!

    private var newsContainer = NewsContainer()

    func getData(for type: SectionType) {
        //NewsManager.instance.setFilter(filter: newsContainer.filter, forType: type)
        NewsManager.instance.getNews(for: type) { error, results in
            if let (articles, totalResults) = results {
                self.newsContainer.articles = articles
                self.newsContainer.totalResults = totalResults
                self.output.dataChanged(self.newsContainer.articles)
            } else {
                guard let err = error else {
                    return
                }
                print(err)
            }
        }
    }

    func getUrl(_ url: String, complition: @escaping (String, Data?) -> Void) {
        CachedDataLoader.shared.loadData(url: url, completion: complition)
    }
}
