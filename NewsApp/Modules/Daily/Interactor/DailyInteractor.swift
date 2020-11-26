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

    // MARK: - DailyInteractorInput
    func getTopStories() {
        NewsManager.instance.getNews(for: .topStories) { error, results in
            if let (articles, _) = results {
                self.output.topStoriesDataChanged(articles)
            } else {
                guard let err = error else {
                    return
                }
                print(err)
            }
        }
    }

    func getLatestNews() {
        NewsManager.instance.getNews(for: .latestNews) { error, results in
            if let (articles, _) = results {
                self.output.latestNewsDataChanged(articles)
            } else {
                guard let err = error else {
                    return
                }
                print(err)
            }
        }
    }

    func getUrl(_ url: String, complition:@escaping (_ url: String, _ data: Data?) -> Void) {
        CachedDataLoader.shared.loadData(url: url, completion: complition)
    }
}
