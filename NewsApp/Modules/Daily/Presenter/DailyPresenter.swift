//
//  DailyDailyPresenter.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//
import Foundation

class DailyPresenter: DailyModuleInput, DailyViewOutput, DailyInteractorOutput {

    weak var view: DailyViewInput!
    var interactor: DailyInteractorInput!
    var router: DailyRouterInput!

    var latestNewsViewModel: LatestNewsViewModel?
    var topStoriesViewModel: TopStoriesViewModel?

    // MARK: - DailyViewOutput
    func viewIsReady() {
        interactor.getTopStories()
        interactor.getLatestNews()
    }

    // MARK: - DailyInteractorOutput
    func latestNewsDataChanged(_ articles: [News]) {
        //prepare view model
        latestNewsViewModel = LatestNewsViewModel(articles: articles)
        updateDataForView()
    }

    func topStoriesDataChanged(_ articles: [News]) {
        //prepare view model
        var array = [News]()
        if articles.count > 0 {
            array.append(articles.first!)
        }
        topStoriesViewModel = TopStoriesViewModel(articles: array)
        updateDataForView()
    }

    func updateDataForView() {
        var sectionViewModel = [NewsSectionViewModel]()
        if let tsvm = topStoriesViewModel {
            sectionViewModel.append(NewsSectionViewModel(type: .topStories,
                                                         sectionTitle: "Top Story",
                                                         sectionButtonTitle: "More",
                                                         cellIdentifiller: "topStoriesCell",
                                                         articles: tsvm.articles ))
        }
        if let lnvm = latestNewsViewModel {
            sectionViewModel.append(NewsSectionViewModel(type: .latestNews,
                                                         sectionTitle: "Latest News",
                                                         sectionButtonTitle: "See All",
                                                         cellIdentifiller: "latestNewsCell",
                                                         articles: lnvm.articles ))
        }
        view.setViewModel(forSections: sectionViewModel)
    }

    func sectionButtonTapped(withType type:SectionType) {
    }
    func onDetailsTapped(withNews model: News) {
    }
    func onBookmarkTapped(withNews model: News) {
    }

    func getUrl(_ url:String, complition:@escaping (_ url: String, _ data: Data?) -> Void) {
        interactor.getUrl(url, complition: complition)
    }
}
