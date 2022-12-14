//
//  NewsFeedCellLayoutCalculator.swift
//  VkNewsFeedCleanSwift
//
//  Created by Артем Орлов on 25.11.2022.
//

import UIKit

struct Sizes: FeedCellSizes {
    var postLabelFrame: CGRect
    var moreTextButtonFrame: CGRect
    var attachmentFrame: CGRect
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
}

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachementViewModel], isFullSizePost: Bool) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {

    private let screenWidth: CGFloat

    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }

    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachementViewModel], isFullSizePost: Bool) -> FeedCellSizes {

        var showMoreTextButton = false

        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right

        // MARK: - Работа с postLabelFrame

        var postLabelFrame = CGRect(
            origin: CGPoint(
                x: Constants.postLabelInsets.left,
                y: Constants.postLabelInsets.top
            ),
            size: CGSize.zero
        )

        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            var height = text.height(width: width, font: Constants.postLabelFont)

            let limitHeigh = Constants.postLabelFont.lineHeight * Constants.minifiedPostLimitLines

            if !isFullSizePost && height > limitHeigh {
                height = Constants.postLabelFont.lineHeight * Constants.minifiedPostLines
                showMoreTextButton = true
            }

            postLabelFrame.size = CGSize(width:  width, height: height)
        }

        // MARK: - Работа с moreTextButtonFrame

        var moreTextButtonSize = CGSize.zero

        if showMoreTextButton {
            moreTextButtonSize = Constants.moreTextButtonSize
        }

        let moreTextButtonOrigin = CGPoint(x: Constants.moreTextButtonInsets.left, y: postLabelFrame.maxY)

        let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)

        // MARK: - Работа с attachmentFrame

        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInsets.top : moreTextButtonFrame.maxY + Constants.postLabelInsets.bottom

        var attachmentFrame = CGRect(
            origin: CGPoint(x: 0,
                            y: attachmentTop),
            size: CGSize.zero
        )

        //        if let attachment = photoAttachment {
        //            let photoHeight: Float = Float(attachment.heigh)
        //            let photoWidth: Float = Float(attachment.width)
        //            let ratio = CGFloat(photoHeight / photoWidth)
        //            attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
        //        }

        if let attachment = photoAttachments.first {
            let photoHeight: Float = Float(attachment.heigh)
            let photoWidth: Float = Float(attachment.width)
            let ratio = CGFloat(photoHeight / photoWidth)

            if photoAttachments.count == 1 {
                attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
            } else if photoAttachments.count > 1 {
                print("more then 1 photo")
                attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)

            }
        }

        // MARK: - Работа с bottomViewFrame

        let bottomViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY)
        let bottomViewFrame = CGRect(
            origin: CGPoint(
                x: 0,
                y: bottomViewTop
            ),
            size: CGSize(
                width: cardViewWidth,
                height: Constants.bottomViewHeight
            )
        )

        // MARK: - Работа с totalHeight
        let totalHeight = bottomViewFrame.maxY + Constants.cardInsets.bottom

        return Sizes(
            postLabelFrame: postLabelFrame,
            moreTextButtonFrame: moreTextButtonFrame,
            attachmentFrame: attachmentFrame,
            bottomViewFrame: bottomViewFrame,
            totalHeight: totalHeight
        )
    }
}
