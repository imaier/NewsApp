//
//  NewsManager.swift
//  NewsApp
//
//  Created by Ilya Maier on 25.11.2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//
import CoreData
import Foundation

class NewsManager {
    // Singleton
    static let instance = NewsManager()

    private init() {
        newsContainers = SectionType.allCases
            .map({_ in
                NewsContainer()
            })
        newsLoader = NewsLoaderSevice.shared
    }

    func getFilter(forType section: SectionType) -> FilterData {
        return newsContainers[section.rawValue].filter
    }

    func setFilter(
        filter: FilterData,
        forType section: SectionType
    ) {
        newsContainers[section.rawValue].filter = filter
    }

    func getNews(
        for section: SectionType,
        completion:@escaping (_ error: Error?, _ result: ([News], Int)?) -> Void
    ) {
        //look in cache
        let newsContainer = newsContainers[section.rawValue]
        if newsContainer.totalResults != 0, !newsContainer.articles.isEmpty {
            completion(nil, (newsContainer.articles, newsContainer.totalResults))
            return
        }

        DispatchQueue.global(qos: .default).async { [weak self] in
            //load from DB
            self?.loadNewsFromDB(for: section)
            if newsContainer.totalResults != 0, !newsContainer.articles.isEmpty {
                DispatchQueue.main.async {
                    completion(nil, (newsContainer.articles, newsContainer.totalResults))
                }
                return
            }
            //load from network
            self?.loadNewsAndAddToDB(for: section, completion: completion)
        }
    }

    func loadMoreNews(
        for section: SectionType,
        completion:@escaping (_ error: Error?, _ result: ([News], Int)?) -> Void
    ) -> Bool {
        let newsContainer = newsContainers[section.rawValue]
        if newsContainer.totalResults != 0 && newsContainer.totalResults == newsContainer.articles.count {
            return false
        }
        loadNewsAndAddToDB(for: section, completion: completion)
        return true
    }

    private var newsContainers: [NewsContainer]
    private let newsLoader: NewsLoaderSevice
}

// MARK: - Private functions
private extension NewsManager {
    func loadNewsAndAddToDB(
        for section: SectionType,
        completion:@escaping (_ error: Error?, _ result: ([News], Int)?) -> Void
    ) {
        let newsContainer = newsContainers[section.rawValue]
        DispatchQueue.global(qos: .default).async { [weak self] in
            //load from network
            self?.loadNextPage(for: section, completion: { error, result in
                guard error == nil else {
                    DispatchQueue.main.async {
                        completion(error, result)
                    }
                    return
                }
                if !newsContainer.articles.isEmpty {
                    self?.saveNewsToDB(for: section)
                    self?.loadNewsFromDB(for: section)
                    DispatchQueue.main.async {
                        completion(nil, (newsContainer.articles, newsContainer.totalResults))
                    }
                    return
                }
                //no error but result is empty
                DispatchQueue.main.async {
                    completion(nil, (newsContainer.articles, newsContainer.totalResults))
                }
            })
        }
    }

    func loadNextPage(
        for section: SectionType,
        completion:@escaping (_ error: Error?, _ result: ([News], Int)?) -> Void
    ) {
        let newsContainer = newsContainers[section.rawValue]
        var page = 1
        if newsContainer.totalResults > 0 || newsContainer.totalResults == -1 {
            page = newsContainer.articles.count / newsContainer.filter.pageSize + 1
        }
        var loadFunc = newsLoader.loadTopStories
        if section == .latestNews {
            loadFunc = newsLoader.loadNews
        }
        loadFunc(newsContainer.filter, page) { error, results in
            if let (articles, totalResults) = results {
                if page == 1 {
                    newsContainer.articles = articles
                } else {
                    newsContainer.articles.append(contentsOf: articles)
                }
                newsContainer.totalResults = totalResults
                completion(nil, (newsContainer.articles, newsContainer.totalResults))
            } else {
                guard let err = error else {
                    return
                }
                print(err)
                completion(error, nil)
            }
        }
    }

    func saveNewsToDB(
        for type: SectionType
    ) {
        let newsContainer = newsContainers[type.rawValue]
        //let nes = NewsMO.init(context: CoreDataManager.instance.managedObjectContext)
        //nes.inBoookmarks
        let req: NSFetchRequest<NewsMO> = NewsMO.fetchRequest()
        let predicate = NSPredicate(
            format: "%K == %@ AND %K == %@",
            "newsType",
            NSNumber(value: type.rawValue),
            "inBoookmarks",
            false)
        req.predicate = predicate

        CoreDataManager.instance.managedObjectContext.performAndWait {
            CoreDataManager.instance.saveContext()
            do {
                let result = try CoreDataManager.instance.managedObjectContext.fetch(req)
                result.forEach { newsMO in
                    CoreDataManager.instance.managedObjectContext.delete(newsMO)
                }
                //CoreDataManager.instance.saveContext()
                newsContainer.articles.forEach { news in
                    let newsMO = NewsMO(context: CoreDataManager.instance.managedObjectContext)
                    newsMO.fill(with: news, andType: type)
                }
                CoreDataManager.instance.saveContext()
            } catch {
                print(error)
            }
        }
    }

    func loadNewsFromDB(
        for type: SectionType
    ) {
        let newsContainer = newsContainers[type.rawValue]
        //let nes = NewsMO.init(context: CoreDataManager.instance.managedObjectContext)
        //nes.publishedAt
        let req: NSFetchRequest<NewsMO> = NewsMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "publishedAt", ascending: false)
        req.sortDescriptors = [sortDescriptor]
        let predicate = NSPredicate(format: "%K == %@", "newsType", NSNumber(value: type.rawValue))
        req.predicate = predicate
        CoreDataManager.instance.managedObjectContext.performAndWait {
            do {
                let result = try CoreDataManager.instance.managedObjectContext.fetch(req)
                let news = result.map { News(with: $0) }
                if !news.isEmpty {
                    newsContainer.articles = news
                    newsContainer.totalResults = -1
                }
            } catch {
                print(error)
            }
        }
    }
}
