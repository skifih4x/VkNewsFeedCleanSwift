//
//  NewsFeedPresenter.swift
//  VkNewsFeedCleanSwift
//
//  Created by Артем Орлов on 23.11.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedPresentationLogic {
    func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {

    weak var viewController: NewsFeedDisplayLogic?

    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }()

    func presentData(response: NewsFeed.Model.Response.ResponseType) {
        switch response {
        case .presentNewsFeed(feed: let feed):

            let cells = feed.items.map { feedItem in
                cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups)
            }

            let feedViewModel = FeedViewModel.init(cells: cells)
            viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayNewsFeed(feedViewModel: feedViewModel))

        }
    }
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group]) -> FeedViewModel.Cell {

        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        let date = Date(timeIntervalSince1970: feedItem.date)

        let dateTitle = dateFormatter.string(from: date)

      return  FeedViewModel.Cell.init(
        iconUrlString: profile.photo,
            name: profile.name,
            date: dateTitle,
            text: feedItem.text,
            likes: String(feedItem.likes?.count ?? 0),
            comments: String(feedItem.comments?.count ?? 0),
            shares: String(feedItem.reposts?.count ?? 0),
            views: String(feedItem.views?.count ?? 0)
        )
    }

    private func profile(for sourceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresenatable {
        let profilesOrGroups: [ProfileRepresenatable] = sourceId >= 0 ? profiles : groups
        let normalSourceId = sourceId >= 0 ? sourceId : -sourceId
        let profileRepresentable = profilesOrGroups.first { myProfileRepresentable in
            myProfileRepresentable.id == normalSourceId
        }
        return profileRepresentable!
    }
}
