//
//  GalleryCollectionViewCell.swift
//  VkNewsFeedCleanSwift
//
//  Created by Артем Орлов on 26.11.2022.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {

    static let reuseId = "GalleryCollectionViewCell"

    let myImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(myImageView)
        backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)

        myImageView.fillSuperview()

    }

    override func prepareForReuse() {
        myImageView.image = nil
    }

    func set(imageUrl: String?) {
        myImageView.set(imageURL: imageUrl)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
