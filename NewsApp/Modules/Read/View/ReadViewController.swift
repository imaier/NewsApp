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

    @IBOutlet weak var sourceImageView: UIImageView!
    @IBOutlet weak var sourceTitleLabel: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var publishDate: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var bookmarkBarButton: UIBarButtonItem!
    @IBOutlet weak var newsImageHeight: NSLayoutConstraint!

    @IBAction func bookmark(_ sender: Any) {
        output.onBookmarkTapped()
    }
    @IBAction func share(_ sender: Any) {
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
        publishDate.text = model.publishedAt

        let sRFC3339DateFormatter = DateFormatter()
        sRFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
        sRFC3339DateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
        if let date = sRFC3339DateFormatter.date(from: model.publishedAt) {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            formatter.locale =  Locale(identifier: "en_US")
            let result  = formatter.string(from: date)
            publishDate.text = result
        } else {
            publishDate.text = model.publishedAt
        }

        contentLabel.text = model.description + "\n" + model.content
        bookmarkBarButton.image =
            model.inBoookmarks == false ? UIImage(named: "bookmark") : UIImage(named: "bookmarkSelected")
        //bookmarkButton.isSelected  = model.inBoookmarks
        self.output.getUrl(model.urlToImage) { [weak self] (_, data) in
            guard let data = data else {
                self?.setNewsImage(UIImage(named: "latestnews"))
                return
            }
            let image = UIImage(data: data)
            self?.setNewsImage(image)
        }
    }

    func setNewsImage(_ image:UIImage?) {
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
