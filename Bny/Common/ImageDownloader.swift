//
//  ImageDownloader.swift
//  Bny
//
//  Created by Abirami on 14/08/26.
//

import Foundation
import UIKit

final class ImageDownloader {

    static let shared = ImageDownloader()

    private init() {}

    func loadImage(from path:String?,into imageView:UIImageView) {
        guard let path = path,
              let url = URL(string:APIConstants.baseURLImage + path) else {
            imageView.image = UIImage(named:"Placeholder")
            return
        }

        URLSession.shared.dataTask(with:url) { data,_,_ in
            DispatchQueue.main.async {
                if let data = data,
                   let image = UIImage(data:data) {
                    imageView.image = image
                } else {
                    imageView.image = UIImage(named:"Placeholder")
                }
            }
        }.resume()
    }
}



