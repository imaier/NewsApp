//
//  NewsListViewCell.swift
//  NewsApp
//
//  Created by Ilya Maier on 17.11.2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import UIKit

protocol NewsListCellDetails : NewsCellDetails {
    var relativDate: String {get set}
}

extension NewsListCellDetails {
    func setRelativDate(with date:Date) {
        let formatter = RelativeDateTimeFormatter()
        let now = Date()
        let relativeTime = formatter.localizedString(for: date, relativeTo: now)
        self.relativDate = relativeTime
    }

    func fillStrings(with model: News) {
        bookmarkState = model.inBoookmarks
        title = model.title
        //newsCell.headImage = nil
        sourceTitle = model.newsSource.name
        let sRFC3339DateFormatter = DateFormatter()
        sRFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
        sRFC3339DateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
        if let date = sRFC3339DateFormatter.date(from: model.publishedAt) {
            setRelativDate(with: date)
        }
    }
}

class NewsListViewCell: UITableViewCell, NewsListCellDetails {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let size = sourceImageView.frame.size
        let radius = min(size.height, size.width) / 2
        sourceImageView.layer.cornerRadius = radius
    }

    @IBOutlet private weak var newsImage: UIImageView!
    @IBOutlet private weak var newsTitle: UILabel!
    @IBOutlet private weak var sourceImageView: UIImageView!
    @IBOutlet private weak var sourceTitleLabel: UILabel!
    @IBOutlet private weak var relativDateLabel: UILabel!
    @IBOutlet private weak var bookmarkButton: UIButton!
    @IBOutlet private weak var detailsButton: UIButton!
    @IBAction private func details(_ sender: Any) {
        onMoreTapped()
    }
    @IBAction private func bookmark(_ sender: Any) {
        onBookmarkTapped()
    }

    // MARK: - NewsCellDetails protocol
    var bookmarkState:Bool {
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

    // MARK: - NewsListCellDetails
    var relativDate: String {
        get {
            return relativDateLabel.text ?? ""
        }
        set(newTitle) {
            relativDateLabel.text = newTitle
        }
    }
}
