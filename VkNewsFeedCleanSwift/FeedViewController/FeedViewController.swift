//
//  FeedViewController.swift
//  VkNewsFeedCleanSwift
//
//  Created by Артем Орлов on 22.11.2022.
//

import UIKit

class FeedViewController: UIViewController {

    private let networkService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red

        networkService.getFeed()
    }
}
