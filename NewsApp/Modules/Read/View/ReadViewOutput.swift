//
//  ReadReadViewOutput.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//
import Foundation

protocol ReadViewOutput {
    /**
        @author Ilya Maier
        Notify presenter that view is ready
    */

    func viewIsReady()
    func getUrl(_ url: String, complition:@escaping (_ url: String, _ data: Data?) -> Void)
    func onBookmarkTapped()
    func onShareTapped()
}
