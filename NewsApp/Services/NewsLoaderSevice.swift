//
//  NewsLoaderSevice.swift
//  NewsApp
//
//  Created by Ilya Maier on 08.11.2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NewsLoaderSevice: NSObject {
    static let shared  = NewsLoaderSevice()

    func loadNews(with filter:FilterData, page pageNum: Int = 0,
                  completion:@escaping (_ error:Error?, _ result:([News], Int)?) -> Void) {
        var params = paramsForFilter(filter)
        
        params["country"] = FilterData.countries()[filter.country]
        if filter.category != noFilterIndex {
            params["category"] = FilterData.categories()[filter.category]
        }

        if pageNum > 0 {
           params["page"] = String(pageNum)
        }
        
        AF.request("https://newsapi.org/v2/top-headlines", parameters: params)
          .validate()
          .response { response in
            //let val = response.value
            
            switch response.result {
            case .success(let value):
                guard let data = value else {
                    completion(nil, nil)
                    return
                }
                let json = JSON(data)
                let articles = json["articles"]
                let totalResults = json["totalResults"].intValue
                if articles.type == .array {
                    let newsArray = articles.arrayValue.map { (jsonNews) -> News in
                        return News(urlToImage: jsonNews["urlToImage"].stringValue,
                                    title: jsonNews["title"].stringValue,
                                    url: jsonNews["url"].stringValue,
                                    description: jsonNews["description"].stringValue,
                                    author: jsonNews["author"].stringValue,
                                    publishedAt: jsonNews["publishedAt"].stringValue,
                                    content: jsonNews["content"].stringValue)
                    }

                    DispatchQueue.main.async {
                        completion(nil, (newsArray, totalResults))
                    }
                }
                print("JSON: \(json)")
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(error, nil)
                }
                print(error)
            }
        }
    }
    
    func loadTopStories(with filter:FilterData, page pageNum: Int = 0,
                        completion:@escaping (_ error:Error?, _ result:([News], Int)?) -> Void) {
        var params = paramsForFilter(filter)

        if pageNum > 0 {
            params["page"] = String(pageNum)
        }

        //&from=2020-11-07&to=2020-11

        //let now = Date()
        //params["from"] = "2020-11-07"
        //params["to"] =  params["from"]

        params["q"] = "yandex"
        params["language"] = "ru"
        params["sortBy"] = "popularity"
        /*
        Required parameters are missing, the scope of your search is too broad.
         Please set any of the following required parameters and try again: q, qInTitle, sources, domains
        */

        AF.request("https://newsapi.org/v2/everything", parameters: params)
          //.validate(statusCode: 200..<500)
          //.validate(contentType: ["application/json"])
          .validate()
          .response { response in
            switch response.result {
            case .success(let value):
                guard let data = value else {
                    completion(nil, nil)
                    return
                }
                let json = JSON(data)
                let articles = json["articles"]
                let totalResults = json["totalResults"].intValue
                if articles.type == .array {
                    let newsArray = articles.arrayValue.map { (jsonNews) -> News in
                        let sourceJson = jsonNews["source"]
                        let source = NewsSource(id: sourceJson["id"].string, name: sourceJson["name"].stringValue)
                        return News(newsSource: source,
                                    urlToImage: jsonNews["urlToImage"].stringValue,
                                    title: jsonNews["title"].stringValue,
                                    url: jsonNews["url"].stringValue,
                                    description: jsonNews["description"].stringValue,
                                    author: jsonNews["author"].stringValue,
                                    publishedAt: jsonNews["publishedAt"].stringValue,
                                    content: jsonNews["content"].stringValue)
                    }

                    DispatchQueue.main.async {
                        completion(nil, (newsArray, totalResults))
                    }
                }
                print("JSON: \(json)")
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(error, nil)
                }
                print(error)
            }
        }
    }

    private func paramsForFilter(_ filter: FilterData) -> [String:String] {
        var params = ["apiKey": "e85917ff05654dc3bcb04e750ac9cbf0"]

        if !filter.keywords.isEmpty {
            params["q"] = filter.keywords
        }
        params["pageSize"] = String(filter.pageSize)

        return params
    }
}
