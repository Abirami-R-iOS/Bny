//
//  FavouritesEntity.swift
//  Bny
//
//  Created by Abirami on 04/07/26.
//

import Foundation
import UIKit
enum FavouriteTab {
    case categories
    case brands
}


struct FavouriteCategory {
    let image: String
    let title: String
    let count: Int
}

struct FavouriteBrand {
    let image: String
    let title: String
    let subtitle: String
    let distance: String
}


struct FavouriteRequest: Codable {

    let latitude: String
    let longitude: String
    let userId: String
    let favourite: String

    enum CodingKeys: String, CodingKey {
        case latitude = "u_latitude"
        case longitude = "u_longitude"
        case userId = "user_id"
        case favourite
    }
}

typealias FavouriteResponse = BaseResponse<[FavouriteResponseModel]>

struct FavouriteResponseModel: Codable {

    let id: Int?
    let categoriesName: String?
    let label: String?
    let picture: String?
    let description: String?
    let offerValue: Int?
    let offerDescription: String?
    let status: String?
    let createdAt: String?
    let updatedAt: String?
    let isFavourite: Int?
    
    var image: UIImage?
    
    var imageHeight: CGFloat = 200
    enum CodingKeys: String, CodingKey {
        case id
        case categoriesName = "C_name"
        case label
        case picture = "C_picture"
        case description
        case offerValue = "offer_value"
        case offerDescription = "offer_description"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case isFavourite = "is_favourite"
    }
}
