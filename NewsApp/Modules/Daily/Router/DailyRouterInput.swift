//
//  DailyDailyRouterInput.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import Foundation

protocol DailyRouterInput {

    func sectionButtonTapped(withType type:SectionType)
    
    func detailsButtonTapped(withNews model: News)
}

/*
transitionHandler.openModule?(usingSegue: "").thenChain({ (moduleInput:RamblerViperModuleInput?) -> RamblerViperModuleOutput? in
        if let newsListModuleInput = moduleInput as? NewsListModuleInput {
            newsListModuleInput.moduleConfiguration(with: type)
        }
        return nil
    })
*/

/*
transitionHandler.openModuleUsingSegue?("SectionDetails")?
    .thenChainUsingBlock({ (moduleInput:NewsListModuleInput?) -> RamblerViperModuleOutput? in
        moduleInput?.moduleConfiguration(with: type)
        return nil
    })
  
*/

/*
let ret = transitionHandler.openModuleUsingSegue(
    usingSegue: "SectionDetails")

    
if let rrr = ret {
    rrr.thenChain { (moduleInput:NewsListModuleInput) -> RamblerViperModuleOutput? in
        moduleInput?.moduleConfiguration(with: type)
        return nil
    }
}*/
    
    /*
    .thenChain({ (moduleInput:NewsListModuleInput?) -> RamblerViperModuleOutput? in
    moduleInput?.moduleConfiguration(with: type)
    return nil
})
 */
