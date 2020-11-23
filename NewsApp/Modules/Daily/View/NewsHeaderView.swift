//
//  NewsHeaderView.swift
//  NewsApp
//
//  Created by Ilya Maier on 12.11.2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import UIKit

extension UIView {
    @discardableResult   // 1
    static func fromNib<T: UIView>() -> T? {   // 2
        let nibName = String(describing: T.self)
        guard let contentView = Bundle(for: T.self)
                .loadNibNamed(nibName, owner: self, options: nil)?.first as? T else {    // 3
            // xib not loaded, or its top view is of the wrong type
            return nil
        }
        return contentView   // 7
    }
}

class NewsHeaderView: UIView {
    // swiftlint:disable:next private_outlet
    @IBOutlet weak var headerTitle: UILabel!
    // swiftlint:disable:next private_outlet
    @IBOutlet weak var headerButton: UIButton!

    var onHeaderButtonTapped: () -> Void = {}

    required init?(coder aDecoder: NSCoder) {   // 2 - storyboard initializer
       super.init(coder: aDecoder)
    }

    init() {   // 3 - programmatic initializer
       super.init(frame: CGRect.zero)  // 4.
    }

    @IBAction private func headerButtonTapped(_ sender: Any) {
        onHeaderButtonTapped()
    }
}
