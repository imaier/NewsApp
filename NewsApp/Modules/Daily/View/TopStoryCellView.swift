//
//  TopStoryCellView.swift
//  NewsApp
//
//  Created by Ilya Maier on 13.11.2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import UIKit

protocol NewsCellDetails: AnyObject {
    var bookmarkState: Bool { get set }
    var title: String { get set }
    var headImage: UIImage? { get set }
    var sourceImage: UIImage? { get set }
    var sourceTitle: String { get set }
    var onMoreTapped: () -> Void { get set }
    var onBookmarkTapped: () -> Void { get set }
}

class TopStoryCellView: UITableViewCell, NewsCellDetails {
    @IBOutlet private weak var newsImage: UIImageView!
    @IBOutlet private weak var newsTitle: UILabel!
    @IBOutlet private weak var sourceImageView: UIImageView!
    @IBOutlet private weak var sourceTitleLabel: UILabel!
    @IBOutlet private weak var bookmarkButton: UIButton!
    @IBOutlet private weak var detailsButton: UIButton!

    @IBAction private func details(_ sender: Any) {
        onMoreTapped()
    }
    @IBAction private func bookmark(_ sender: Any) {
        onBookmarkTapped()
    }

    // MARK: - NewsCellDetails protocol
    var bookmarkState: Bool {
        get {
            return bookmarkButton.isSelected
        }
        set(newState) {
            bookmarkButton.isSelected = newState
        }
    }
    var title: String {
        get {
            return newsTitle.text ?? ""
        }
        set(newTitle) {
            newsTitle.text = newTitle
        }
    }
    var headImage: UIImage? {
        get {
            return newsImage.image
        }
        set(newImg) {
            newsImage.image = newImg
        }
    }

    var sourceTitle: String {
        get {
            return sourceTitleLabel.text ?? ""
        }
        set(newTitle) {
            sourceTitleLabel.text = newTitle
        }
    }
    var sourceImage: UIImage? {
        get {
            return sourceImageView.image
        }
        set(newImg) {
            sourceImageView.image = newImg
        }
    }

    var onMoreTapped: () -> Void = {}
    var onBookmarkTapped: () -> Void = {}

    override func layoutSubviews() {
        superview?.layoutSubviews()
        let size = sourceImageView.frame.size
        let radius = min(size.height, size.width) / 2
        sourceImageView.layer.cornerRadius = radius
    }
}
