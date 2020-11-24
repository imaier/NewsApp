//
//  NewsLoaderSevice.swift
//  NewsApp
//
//  Created by Ilya Maier on 08.11.2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import Alamofire
import Foundation

class NewsLoaderSevice: NSObject {
    static let shared = NewsLoaderSevice()

    func loadNews(
        with filter: FilterData,
        page pageNum: Int = 0,
        completion:@escaping (_ error: Error?, _ result: ([News], Int)?) -> Void
    ) {
        var params = paramsForFilter(filter)

        params["country"] = FilterData.countries()[filter.country]
        if filter.category != noFilterIndex {
            params["category"] = FilterData.categories()[filter.category]
        }

        if pageNum > 0 {
           params["page"] = String(pageNum)
        }

        loadAndParse(
            request: "https://newsapi.org/v2/top-headlines",
            parameters: params,
            completion: completion)
    }

    func loadTopStories(
        with filter: FilterData,
        page pageNum: Int = 0,
        completion:@escaping (_ error: Error?, _ result: ([News], Int)?) -> Void
    ) {
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

        loadAndParse(
            request: "https://newsapi.org/v2/everything",
            parameters: params,
            completion: completion)
    }

    private func loadAndParse<Parameters: Encodable>(
        request url: String,
        parameters params: Parameters?,
        completion:@escaping (_ error: Error?, _ result: ([News], Int)?) -> Void
    ) {
        AF.request(url, parameters: params)
          //.validate(statusCode: 200..<500)
          //.validate(contentType: ["application/json"])
          .validate()
          .response { response in
            switch response.result {
            case .success(let value):
                guard let data = value else {
                    DispatchQueue.main.async {
                        completion(nil, nil)
                    }
                    return
                }
                let json = String(bytes: data, encoding: .utf8)
                print(json ?? "no data")
                let decoder = JSONDecoder()

                let sRFC3339DateFormatter = DateFormatter()
                sRFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
                sRFC3339DateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
                decoder.dateDecodingStrategy = .formatted(sRFC3339DateFormatter)
                do {
                    let newsResponse = try decoder.decode(NewsResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(nil, (newsResponse.articles, newsResponse.totalResults))
                    }
                } catch {
                    print(error)
                    DispatchQueue.main.async {
                        completion(error, nil)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(error, nil)
                }
                print(error)
            }
        }
    }

    private func paramsForFilter(_ filter: FilterData) -> [String: String] {
        var params = ["apiKey": "e85917ff05654dc3bcb04e750ac9cbf0"]

        if !filter.keywords.isEmpty {
            params["q"] = filter.keywords
        }
        params["pageSize"] = String(filter.pageSize)

        return params
    }
}
