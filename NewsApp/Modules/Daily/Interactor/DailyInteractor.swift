//
//  DailyDailyInteractor.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//
import Foundation

class DailyInteractor: DailyInteractorInput {

    weak var output: DailyInteractorOutput!

    private var topStories = NewsContainer()
    private var latestNews = NewsContainer()

    // MARK: - DailyInteractorInput
    func getTopStories() {
        var page = 1
        if topStories.totalResults > 0 {
            page = topStories.articles.count / topStories.filter.pageSize + 1
        }
        NewsLoaderSevice.shared.loadTopStories(with: topStories.filter, page: page) { (error, results) in
            if let (articles, totalResults) = results {
                if page == 1 {
                    self.topStories.articles = articles
                } else {
                    self.topStories.articles.append(contentsOf: articles)
                }
                self.topStories.totalResults = totalResults

                self.output.topStoriesDataChanged(self.topStories.articles)
            } else {
                guard let err = error else {
                    return
                }
                print(err)
            }
        }
    }

    func getLatestNews() {
        var page = 1
        if latestNews.totalResults > 0 {
            page = latestNews.articles.count / latestNews.filter.pageSize + 1
        }
        NewsLoaderSevice.shared.loadNews(with: latestNews.filter, page: page) { (error, results) in
            if let (articles, totalResults) = results {
                if page == 1 {
                    self.latestNews.articles = articles
                } else {
                   self.latestNews.articles.append(contentsOf: articles)
                }
                self.latestNews.totalResults = totalResults

                self.output.latestNewsDataChanged(self.latestNews.articles)
            } else {
                guard let err = error else {
                    return
                }
                print(err)
            }
        }
    }

    func getUrl(_ url:String, complition:@escaping (_ url: String, _ data: Data?) -> Void) {
        CachedDataLoader.shared.loadData(url: url, completion: complition)
    }

}
