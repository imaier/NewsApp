//
//  CachedDataLoader.swift
//  TopNews
//
//  Created by Ilya Maier on 31.05.2020.
//  Copyright © 2020 mera. All rights reserved.
//

import Foundation

class CachedDataLoader {
    static let shared = CachedDataLoader()

    fileprivate var cache: [String: Data] = [:]
/*
    func loadImage(url: String, comletition:@escaping (_ url: String, _ image: UIImage?)-> Void) {
        if let data = self.cache[url] {
            let img = UIImage.init(data: data)
            comletition(url, img)
        } else {
            if let imgUrl = URL(string: url) {
                let task = URLSession.shared.dataTask(with: imgUrl ) { (data: Data?, _: URLResponse?, _: Error?) in
                    if let data = data {
                        let img = UIImage.init(data: data)
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(1), execute: {
                            self.cache[url] = data
                            comletition(url, img)
                        })
                    } else {
                        DispatchQueue.main.async {
                            comletition(url, nil)
                        }
                    }
                }
                task.resume()
            } else {
                comletition(url, nil)
            }
        }
    }
*/
    func loadData(url: String, completion:@escaping (_ url: String, _ data: Data?) -> Void) {
        if let data = self.cache[url] {
            completion(url, data)
        } else {
            if let dataUrl = URL(string: url) {
                let task = URLSession.shared.dataTask(with: dataUrl) { (data: Data?, _: URLResponse?, _: Error?) in
                    if let data = data {
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(1),
                                                      execute: {
                            self.cache[url] = data
                            completion(url, data)
                        })
                    } else {
                        DispatchQueue.main.async {
                            completion(url, nil)
                        }
                    }
                }
                task.resume()
            } else {
                completion(url, nil)
            }
        }
    }
}
