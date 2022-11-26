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
    var cellLaoutCalculator: FeedCellLayoutCalculatorProtocol = FeedCellLayoutCalculator()

    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }()

    func presentData(response: NewsFeed.Model.Response.ResponseType) {
        switch response {
        case .presentNewsFeed(feed: let feed, let revealdedPostIds):

            print(revealdedPostIds)
            let cells = feed.items.map { feedItem in
                cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups, revealdedPostIds: revealdedPostIds)
            }

            let feedViewModel = FeedViewModel.init(cells: cells)
            viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayNewsFeed(feedViewModel: feedViewModel))

        }
    }
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group], revealdedPostIds: [Int]) -> FeedViewModel.Cell {

        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)

        let photoAttachments = self.photoAttachments(feedItem: feedItem)

        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)

        let isFullSize = revealdedPostIds.contains { postId in
            postId == feedItem.postId
        }

        let sizes = cellLaoutCalculator.sizes(postText: feedItem.text, photoAttachments: photoAttachments, isFullSizePost: isFullSize)

        return  FeedViewModel.Cell.init(
            postId: feedItem.postId,
            iconUrlString: profile.photo,
            name: profile.name,
            date: dateTitle,
            text: feedItem.text,
            likes: String(feedItem.likes?.count ?? 0),
            comments: String(feedItem.comments?.count ?? 0),
            shares: String(feedItem.reposts?.count ?? 0),
            views: String(feedItem.views?.count ?? 0),
            photoAttachements: photoAttachments,
            sizes: sizes
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

    private func photoAttachment(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachment? {
        guard let photos = feedItem.attachments?.compactMap({ attachment in
            attachment.photo
        }), let firstPhoto = photos.first else {
            return nil
        }
        return FeedViewModel.FeedCellPhotoAttachment.init(
            photoUrlString: firstPhoto.srcBIG,
            width: firstPhoto.width,
            heigh: firstPhoto.heigh
        )
    }

    private func photoAttachments(feedItem: FeedItem) -> [FeedViewModel.FeedCellPhotoAttachment] {
        guard let attachments = feedItem.attachments else { return [] }

        return attachments.compactMap { attachment -> FeedViewModel.FeedCellPhotoAttachment? in
            guard let photo = attachment.photo else { return nil }
            return FeedViewModel.FeedCellPhotoAttachment(photoUrlString: photo.srcBIG,
                                                         width: photo.width,
                                                         heigh: photo.heigh)
        }
    }
}
