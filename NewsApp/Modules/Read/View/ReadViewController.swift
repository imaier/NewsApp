//
//  ReadReadViewController.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import UIKit

class ReadViewController: UIViewController, ReadViewInput {
    var output: ReadViewOutput!

    @IBOutlet private weak var sourceImageView: UIImageView!
    @IBOutlet private weak var sourceTitleLabel: UILabel!
    @IBOutlet private weak var newsTitle: UILabel!
    @IBOutlet private weak var publishDate: UILabel!
    @IBOutlet private weak var newsImage: UIImageView!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var bookmarkBarButton: UIBarButtonItem!
    @IBOutlet private weak var newsImageHeight: NSLayoutConstraint!

    @IBAction private func bookmark(_ sender: Any) {
        output.onBookmarkTapped()
    }
    @IBAction private func share(_ sender: Any) {
        output.onShareTapped()
    }

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    // MARK: ReadViewInput
    func setupInitialState() {
    }

    func update(with model: News) {
        sourceTitleLabel.text = model.newsSource.name
        newsTitle.text = model.title
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "en_US")
        let result = formatter.string(from: model.publishedAt)
        publishDate.text = result
        contentLabel.text = model.description + "\n" + (model.content ?? "")
        bookmarkBarButton.image =
            model.inBoookmarks == false ? UIImage(named: "bookmark") : UIImage(named: "bookmarkSelected")
        //bookmarkButton.isSelected  = model.inBoookmarks
        if let urlToImage = model.urlToImage {
            self.output.getUrl(urlToImage) { [weak self] _, data in
                guard let data = data else {
                    self?.setNewsImage(UIImage(named: "latestnews"))
                    return
                }
                let image = UIImage(data: data)
                self?.setNewsImage(image)
            }
        } else {
            self.setNewsImage(UIImage(named: "latestnews"))
        }
    }

    func setNewsImage(_ image: UIImage?) {
        guard let image = image  else {
            self.newsImageHeight.constant = 80
            self.newsImage.image = nil
            return
        }
        let width = self.newsImage.frame.size.width
        let ratio = image.size.height / image.size.width
        self.newsImageHeight.constant = width * ratio
        self.newsImage.image = image
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = sourceImageView.frame.size
        let radius = min(size.height, size.width) / 2
        sourceImageView.layer.cornerRadius = radius
    }
}
