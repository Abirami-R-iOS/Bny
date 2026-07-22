//
//  ImageViewExtension.swift
//  Bny
//
//  Created by Abirami on 22/07/26.
//

import Foundation
import UIKit

extension UIImageView {

    func loadImage(
        from urlString: String,
        placeholder: UIImage? = nil
    ) {

        self.image = placeholder

        guard let url = URL(string: urlString) else {
            print("❌ Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in

            if let error = error {
                print("❌ Error:", error)
                return
            }

            if let response = response as? HTTPURLResponse {
                print("✅ Status Code:", response.statusCode)
                print("✅ MIME Type:", response.mimeType ?? "")
            }

            guard let data = data else {
                print("❌ No Data")
                return
            }

            print("✅ Data Size:", data.count)

            if let responseString = String(data: data, encoding: .utf8) {
                print("Response:", responseString)
            }

            guard let image = UIImage(data: data) else {
                print("❌ UIImage init failed")
                return
            }

            DispatchQueue.main.async {
                self?.image = image
            }

        }.resume()
    }
}
