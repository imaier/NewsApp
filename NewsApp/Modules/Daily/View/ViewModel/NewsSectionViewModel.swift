//
//  NewsSectionViewModel.swift
//  NewsApp
//
//  Created by Ilya Maier on 11.11.2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import Foundation

enum SectionType: Int, CaseIterable {
    case topStories = 0
    case latestNews
}

struct NewsSectionViewModel {
    let type: SectionType
    let sectionTitle: String
    let sectionButtonTitle: String
    let cellIdentifiller: String
    let articles: [News]
}
