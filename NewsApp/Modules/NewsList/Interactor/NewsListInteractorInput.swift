//
//  NewsListNewsListInteractorInput.swift
//  NewsApp
//
//  Created by Ilya Maier on 16/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import Foundation

protocol NewsListInteractorInput {
    func getData(for type: SectionType)
    func getUrl(_ url: String, complition:@escaping (_ url: String, _ data: Data?) -> Void)
}
