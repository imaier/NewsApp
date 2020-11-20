//
//  ReadReadInteractor.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//
import Foundation

class ReadInteractor: ReadInteractorInput {

    weak var output: ReadInteractorOutput!

    func getUrl(_ url: String, complition: @escaping (String, Data?) -> Void) {
        CachedDataLoader.shared.loadData(url: url, completion: complition)
    }
}
