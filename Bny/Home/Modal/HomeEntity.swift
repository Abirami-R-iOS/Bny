//
//  HomeViewEntity.swift
//  Bny
//
//  Created by Abirami on 24/06/26.
//

import Foundation
import UIKit

struct Deals {
    let image: String
    let title: String
    let distance: String
    let offer: String
    var isFavourite: Bool
}


struct BrandList {
    let image: String
    let title: String
    let Location: String
    let distance: String
    let offer: String
    var isFavourite: Bool
}

struct CategoryRequest: Codable {

    let latitude: Double
    let longitude: Double
    let userId: Int
    let favourite: Int

    enum CodingKeys: String, CodingKey {
        case latitude = "u_latitude"
        case longitude = "u_longitude"
        case userId = "user_id"
        case favourite
    }
}

typealias CategoryResponse = BaseResponse<[CategoryResponseModel]>

struct CategoryResponseModel: Codable {

    let id: Int?
    let name: String?
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
        case name = "C_name"
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
