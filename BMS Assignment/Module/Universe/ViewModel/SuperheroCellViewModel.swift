//
//  SuperheroCellViewModel.swift
//  BMS Assignment
//
//  Created by Rahul Patil on 08/01/23.
//

import UIKit

struct SuperheroCellViewModel {
    var updateImage: ((UIImage?) -> Void) = { _ in }
    var name: String
    var imageURL: String?
    var isLeader: Bool?
    var image: UIImage?
    
    func getImage(url: URL, handler: @escaping (UIImage?) -> Void) -> ImageDownloader {
        let imageDownloader = ImageDownloader()
        imageDownloader.startDownload(with: url) { imageData, error in
            handler(imageData)
        }
        return imageDownloader
    }
}
