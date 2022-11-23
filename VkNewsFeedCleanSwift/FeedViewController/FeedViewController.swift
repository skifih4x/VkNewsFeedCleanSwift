//
//  FeedViewController.swift
//  VkNewsFeedCleanSwift
//
//  Created by Артем Орлов on 22.11.2022.
//

import UIKit

class FeedViewController: UIViewController {

    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red

        fetcher.getFeed { feedResponse in
            guard let feedResponse = feedResponse else {return}
            feedResponse.items.map { feedItem in
                print(feedItem.date)
            }
        }

    }
}
