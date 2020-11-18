//
//  NewsListNewsListPresenter.swift
//  NewsApp
//
//  Created by Ilya Maier on 16/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//
import Foundation

class NewsListPresenter: NewsListModuleInput, NewsListViewOutput, NewsListInteractorOutput {

    

    weak var view: NewsListViewInput!
    var interactor: NewsListInteractorInput!
    var router: NewsListRouterInput!

    private var sectionType: SectionType?
    private var articles: [News] = []

    func viewIsReady() {

    }

    func setListType(_ type: SectionType) {
        sectionType = type
        interactor.getData(for: type)
        switch type {
        case .latestNews:
            view.setNavigationTitle("Latest News")
        case .topStories:
            view.setNavigationTitle("Top Stories")
        }
    }

    func dataChanged(_ articles: [News]) {
        self.articles = articles
        self.view.update()
    }

    func getCount() -> Int {
        return self.articles.count
    }

    func getViewModel(for row: Int) -> NewsCellViewModel {
        return NewsCellViewModel(model: self.articles[row])
    }

    func getUrl(_ url:String, complition:@escaping (_ url: String, _ data: Data?) -> Void) {
        interactor.getUrl(url, complition: complition)
    }

    func onDetailsTapped(withNews model: News) {
    }

    func onBookmarkTapped(withNews model: News) {
    }
}
