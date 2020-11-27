//
//  NewsListNewsListViewController.swift
//  NewsApp
//
//  Created by Ilya Maier on 16/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import UIKit

class NewsListViewController: UIViewController, NewsListViewInput {
    var output: (NewsListViewOutput & NewsListModuleInput)!
    @IBOutlet private weak var tableView: UITableView!

    private let cellIdentifier = "newsListCellIdentifier"
    var viewModel = NewsListViewModel(navigationTitle: "", articles: [])

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()

        let cellNib = UINib(nibName: "NewsListViewCell", bundle: Bundle.main)
        tableView?.register(cellNib, forCellReuseIdentifier: cellIdentifier)
    }

   // MARK: NewsListViewInput
    func setupInitialState() {
    }

    func update(with model: NewsListViewModel) {
        loadViewIfNeeded()
        viewModel = model
        navigationItem.title = viewModel.navigationTitle
        tableView.reloadData()
    }
}

extension NewsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        if indexPath.row == self.viewModel.articles.count - 1 {
            self.output.lastCellShowed()
        }

        if let newsCell = cell as? NewsListCellDetails {
            let model = self.viewModel.articles[indexPath.row]
            newsCell.fillStrings(with: model)
            newsCell.onMoreTapped = { [weak self] in
                self?.output.onDetailsTapped(withNews: model)
            }
            newsCell.onBookmarkTapped = { [weak self] in
                self?.output.onBookmarkTapped(withNews: model)
            }
            if let urlToImage = model.urlToImage {
                newsCell.headImage = nil
                self.output.getUrl(urlToImage) { _, data in
                    if newsCell.title == model.title {
                        guard let data = data else {
                            newsCell.headImage = UIImage(named: "latestnews")
                            return
                        }
                        let image = UIImage(data: data)
                        newsCell.headImage = image
                    }
                }
            } else {
                newsCell.headImage = UIImage(named: "latestnews")
            }
        }
        return cell
    }
}
