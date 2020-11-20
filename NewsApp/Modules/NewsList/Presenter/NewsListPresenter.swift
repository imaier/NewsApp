//
//  NewsListNewsListPresenter.swift
//  NewsApp
//
//  Created by Ilya Maier on 16/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//
import Foundation

class NewsListPresenter: NSObject, NewsListModuleInput, NewsListViewOutput, NewsListInteractorOutput {

    weak var view: NewsListViewInput!
    var interactor: NewsListInteractorInput!
    var router: NewsListRouterInput!

    private var sectionType: SectionType = .latestNews
    private var model = NewsListViewModel(navigationTitle: "", articles: [])

    func viewIsReady() {

    }

    // NewsListModuleInput
    func moduleConfiguration(with type: SectionType) {
        sectionType = type
        interactor.getData(for: sectionType)
        switch sectionType {
        case .latestNews:
            model.navigationTitle = "Latest News"
        case .topStories:
            model.navigationTitle = "Top Stories"
        }
        view.update(with:model)
    }

    func dataChanged(_ articles: [News]) {
        self.model.articles = articles
        self.view.update(with: self.model)
    }

    func getUrl(_ url:String, complition:@escaping (_ url: String, _ data: Data?) -> Void) {
        interactor.getUrl(url, complition: complition)
    }

    func onDetailsTapped(withNews model: News) {
        router.detailsButtonTapped(withNews: model)
    }

    func onBookmarkTapped(withNews model: News) {
    }
}
