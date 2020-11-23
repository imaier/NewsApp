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
        var page = 1
        if newsContainer.totalResults > 0 {
            page = newsContainer.articles.count / newsContainer.filter.pageSize + 1
        }
        var loadFunc = NewsLoaderSevice.shared.loadTopStories
        if type == .latestNews {
            loadFunc = NewsLoaderSevice.shared.loadNews
        }
        loadFunc(newsContainer.filter, page) { error, results in
            if let (articles, totalResults) = results {
                if page == 1 {
                    self.newsContainer.articles = articles
                } else {
                    self.newsContainer.articles.append(contentsOf: articles)
                }
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
