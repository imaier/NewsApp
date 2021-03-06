//
//  DailyDailyViewController.swift
//  NewsApp
//
//  Created by Ilya Maier on 08/11/2020.
//  Copyright © 2020 Orion Innovation. All rights reserved.
//

import UIKit

class DailyViewController: UIViewController, DailyViewInput {
    var output: DailyViewOutput!

    private var sectionsViewModel: [NewsSectionViewModel] = []

    @IBOutlet private weak var tableView: UITableView!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    // MARK: DailyViewInput
    func setupInitialState() {
    }

    func performSegue(to type: SectionType) {
        performSegue(withIdentifier: "SectionDetails", sender: type)
    }

    func setViewModel(forSections sections: [NewsSectionViewModel]) {
        self.sectionsViewModel = sections
        self.tableView.reloadData()
    }
}

extension DailyViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                    self.sectionsViewModel[indexPath.section].cellIdentifiller,
                                                 for: indexPath)
        if let newsCell = cell as? NewsCellDetails {
            let model = sectionsViewModel[indexPath.section].articles[indexPath.row]
            newsCell.bookmarkState = model.inBoookmarks
            newsCell.title = model.title
            newsCell.onMoreTapped = { [weak self] in
                self?.output.onDetailsTapped(withNews: model)
            }
            newsCell.onBookmarkTapped = { [weak self] in
                self?.output.onBookmarkTapped(withNews: model)
            }
            var sourceAndTime = model.newsSource.name
            let formatter = RelativeDateTimeFormatter()
            sourceAndTime += " • "
            let now = Date()
            let relativeTime = formatter.localizedString(for: model.publishedAt, relativeTo: now)
            sourceAndTime += relativeTime
            newsCell.sourceTitle = sourceAndTime
            if let urlToImage = model.urlToImage {
                newsCell.headImage = nil
                output.getUrl(urlToImage) { _, data in
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsViewModel[section].articles.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsViewModel.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsViewModel[section].sectionTitle
    }

    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: NewsHeaderView? = .fromNib()
        view?.headerTitle.text = sectionsViewModel[section].sectionTitle
        view?.headerButton.setTitle(sectionsViewModel[section].sectionButtonTitle, for: .normal)
        let type = sectionsViewModel[section].type
        view?.onHeaderButtonTapped = { [weak self] in
            self?.output.sectionButtonTapped(withType: type)
        }
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil //UIView()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}
