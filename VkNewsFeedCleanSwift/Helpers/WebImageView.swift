//
//  WebImageView.swift
//  VkNewsFeedCleanSwift
//
//  Created by Артем Орлов on 24.11.2022.
//

import UIKit
// файл для загрузки изображенияй с кешом
class WebImageView: UIImageView {

    func set(imageURL: String?) {
        guard let imageURL = imageURL, let url = URL(string: imageURL) else {
            self.image = nil
            return }

        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) { //добавление кеша картинок
            self.image = UIImage(data: cachedResponse.data) //добавление кеша картинок
            print("from cache") //добавление кеша картинок
            return //добавление кеша картинок
        }

        print("from internet")

        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self?.image = UIImage(data: data)
                    self?.handleLodedImage(data: data, response: response) //добавление кеша картинок
                }
            }
        }
        dataTask.resume()
    }

    private func handleLodedImage(data: Data, response: URLResponse) { //добавление кеша картинок
        guard let responseUrl = response.url else { return } //добавление кеша картинок
        let cachedResponse = CachedURLResponse(response: response, data: data) //добавление кеша картинок
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseUrl)) //добавление кеша картинок
    }
}
