//
//  NewsFeedCodeCell.swift
//  VkNewsFeedCleanSwift
//
//  Created by Артем Орлов on 26.11.2022.
//

import UIKit

protocol NewsFeedCOdeCellDelegate: AnyObject {
    func revealPost(for cell: NewsFeedCodeCell)
}

class NewsFeedCodeCell: UITableViewCell {

    static let reuseId = "NewsFeedCodeCell"

    weak var delegate: NewsFeedCOdeCellDelegate?

    //first layer
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    //second layer
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    let postLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Constants.postLabelFont
        label.textColor = #colorLiteral(red: 0.2276484668, green: 0.2322214842, blue: 0.236567229, alpha: 1)
        return label
    }()

    let moreTextButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(#colorLiteral(red: 0.4, green: 0.6235294118, blue: 0.831372549, alpha: 1), for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("Показать полность...", for: .normal)
        return button
    }()

    let postImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.backgroundColor = .white
        return imageView
    }()

    let bottomView: UIView = {
        let view = UIView()
        return view
    }()

    //three layer top view
    let iconImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.2276484668, green: 0.2322214842, blue: 0.236567229, alpha: 1)
        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768454671, green: 0.6187268496, blue: 0.6644299626, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    // three layer bottomVIew
    let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let sharesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    //Four layer in bottomView

    let likesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "like")
        return imageView
    }()

    let commentsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "comment")
        return imageView
    }()

    let sharesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "share")
        return imageView
    }()

    let viewsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "eye")
        return imageView
    }()

    let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "457K"
//        label.textColor = #colorLiteral(red: 0.5768454671, green: 0.6187268496, blue: 0.6644299626, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()

    let commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = #colorLiteral(red: 0.5768454671, green: 0.6187268496, blue: 0.6644299626, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()

    let sharesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768454671, green: 0.6187268496, blue: 0.6644299626, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()

    let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = #colorLiteral(red: 0.5768454671, green: 0.6187268496, blue: 0.6644299626, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()

    override func prepareForReuse() {
        iconImageView.set(imageURL: nil)
        postImageView.set(imageURL: nil)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        iconImageView.layer.cornerRadius = Constants.topViewHeight / 2
        iconImageView.clipsToBounds = true

        backgroundColor = .clear
        selectionStyle = .none

        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true

        moreTextButton.addTarget(self, action: #selector(moreTextButtonTouch), for: .touchUpInside)

        overlayFirstLayer() // first layer
        overlaySecondLayer() // second layer
        overlayThirdLayerOnTopView() // three layer top view
        overlayThirdLayerOnBottomView() // three layer bottom view
        overlayFourthLayerOnBottomViewViews() //four layer bottom view
    }

  @objc func moreTextButtonTouch() {
      print("21")
      delegate?.revealPost(for: self)
    }

    func set(viewModel: FeedCellViewModel) {
        iconImageView.set(imageURL: viewModel.iconUrlString )
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views

        postLabel.frame = viewModel.sizes.postLabelFrame
        postImageView.frame = viewModel.sizes.attachmentFrame
        bottomView.frame = viewModel.sizes.bottomViewFrame
        moreTextButton.frame = viewModel.sizes.moreTextButtonFrame

        if let photoAttachment = viewModel.photoAttachement {
            postImageView.set(imageURL: photoAttachment.photoUrlString)
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
    }

    private func overlayFourthLayerOnBottomViewViews() {

        likesView.addSubview(likesImage)
        likesView.addSubview(likesLabel)

        commentsView.addSubview(commentsImage)
        commentsView.addSubview(commentsLabel)

        sharesView.addSubview(sharesImage)
        sharesView.addSubview(sharesLabel)

        viewsView.addSubview(viewsImage)
        viewsView.addSubview(viewsLabel)

        helpInFourthLayer(view: likesView, imageView: likesImage, label: likesLabel)
        helpInFourthLayer(view: commentsView, imageView: commentsImage, label: commentsLabel)
        helpInFourthLayer(view: sharesView, imageView: sharesImage, label: sharesLabel)
        helpInFourthLayer(view: viewsView, imageView: viewsImage, label: viewsLabel)
    }

    private func helpInFourthLayer(view: UIView, imageView: UIImageView, label: UILabel) {


        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize),
            imageView.heightAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize)
        ])


        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor )
        ])
    }

    private func overlayThirdLayerOnBottomView() {
        bottomView.addSubview(likesView)
        bottomView.addSubview(commentsView)
        bottomView.addSubview(sharesView)
        bottomView.addSubview(viewsView)

        likesView.anchor(
            top: bottomView.topAnchor,
            leading: bottomView.leadingAnchor,
            bottom: nil,
            trailing: nil,
            size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight)
        )

        commentsView.anchor(
            top: bottomView.topAnchor,
            leading: likesView.trailingAnchor,
            bottom: nil,
            trailing: nil,
            size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight)
        )

        sharesView.anchor(
            top: bottomView.topAnchor,
            leading: commentsView.trailingAnchor,
            bottom: nil,
            trailing: nil,
            size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight)
        )

        viewsView.anchor(
            top: bottomView.topAnchor,
            leading: nil,
            bottom: nil,
            trailing: bottomView.trailingAnchor,
            size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight)
        )

    }

    private func overlayThirdLayerOnTopView() {
        topView.addSubview(iconImageView)
        topView.addSubview(nameLabel)
        topView.addSubview(dateLabel)


        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            iconImageView.topAnchor.constraint(equalTo: topView.topAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight),
            iconImageView.widthAnchor.constraint(equalToConstant: Constants.topViewHeight)
        ])


        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8),
            nameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 2),
            nameLabel.heightAnchor.constraint(equalToConstant: Constants.topViewHeight / 2 - 2)
        ])


        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8),
            dateLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -2),
            dateLabel.heightAnchor.constraint(equalToConstant: 14)
        ])
    }

    private func overlaySecondLayer() {
        cardView.addSubview(topView)
        cardView.addSubview(postLabel)
        cardView.addSubview(moreTextButton)
        cardView.addSubview(postImageView)
        cardView.addSubview(bottomView)

        // topView constraints

        NSLayoutConstraint.activate([
            topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
            topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8),
            topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8),
            topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight)
        ])
    }

    private func overlayFirstLayer() {
        addSubview(cardView)

        //cardView contstrains
        cardView.fillSuperview(padding: Constants.cardInsets)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
