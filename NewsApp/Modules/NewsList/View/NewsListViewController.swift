//
//  NewsListNewsListViewController.swift
//  NewsApp
//
//  Created by Ilya Maier on 16/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import UIKit

class NewsListViewController: UIViewController, NewsListViewInput {

    var output: NewsListViewOutput!
    @IBOutlet weak var tableView: UITableView!

    private let cellIdentifier = "newsListCellIdentifier"

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()

        let cellNib = UINib(nibName: "NewsListViewCell", bundle: Bundle.main)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
    }

   // MARK: NewsListViewInput
    func setupInitialState() {
    }
    func setNavigationTitle(_ navBarTitle: String) {
        if let navVc = navigationController {
            navVc.title = navBarTitle
        }
        //navigationController?.title = navBarTitle
    }

    func update() {
        tableView.reloadData()
    }
}

extension NewsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.output.getCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        if let newsCell = cell as? NewsListCellDetails {
            let viewModel = self.output.getViewModel(for: indexPath.row)
            newsCell.fillStrings(with: viewModel.model)
            newsCell.onMoreTapped = { [weak self] in
                self?.output.onDetailsTapped(withNews: viewModel.model)
            }
            newsCell.onBookmarkTapped = { [weak self] in
                self?.output.onBookmarkTapped(withNews: viewModel.model)
            }
            //cell.layer.borderWidth = 1
            //cell.layer.borderColor = UIColor.red.cgColor
            newsCell.headImage = nil
            self.output.getUrl(viewModel.model.urlToImage) { (_, data) in
                if newsCell.title == viewModel.model.title {
                    guard let data = data else {
                        newsCell.headImage = UIImage(named: "latestnews")
                        return
                    }
                    let image = UIImage(data: data)
                    newsCell.headImage = image
                }
            }
        }
        return cell
    }
}
