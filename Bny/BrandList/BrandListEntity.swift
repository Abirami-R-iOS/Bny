//
//  BrandListEntity.swift
//  Bny
//
//  Created by Abirami on 12/07/26.
//

import Foundation
import UIKit

struct BrandRequestModel: Encodable {

    let categoryId: Int
    let latitude: Double
    let longitude: Double
    let userId: Int
    let favourite: Int

    enum CodingKeys: String, CodingKey {

        case categoryId = "c_id"
        case latitude = "u_latitude"
        case longitude = "u_longitude"
        case userId = "user_id"
        case favourite
    }
}

typealias BrandResponse = BaseResponse<[BrandListResponseModel]>

struct BrandListResponseModel: Codable {

    let id: Int?
    let categoryId: Int?
    let name: String?
    let email: String?
    let mobile: String?
    let picture: String?
    let address: String?
    let latitude: Double?
    let longitude: Double?
    let city: String?
    let logo: String?
    let video: String?
    let area: String?
    let offerValue: Int?
    let offerDescription: String?
    let offerValidTime: String?
    let description: String?
    let website: String?
    let createdAt: String?
    let updatedAt: String?
    let distance: Int?
    let isFavourite: Int?
    let banners: [BrandBanner]?

    var image: UIImage?
    
    var imageHeight: CGFloat = 200
    
    enum CodingKeys: String, CodingKey {

        case id
        case categoryId = "c_id"
        case name = "s_name"
        case email = "s_email"
        case mobile = "s_mobile"
        case picture = "s_picture"
        case address = "s_address"
        case latitude = "s_latitude"
        case longitude = "s_longitude"
        case city
        case logo = "s_logo"
        case video = "s_video"
        case area = "s_area"
        case offerValue = "offer_value"
        case offerDescription = "offer_description"
        case offerValidTime = "offer_valid_time"
        case description = "s_description"
        case website = "s_website"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case distance = "store_km_from_user"
        case isFavourite = "is_favourite"
        case banners = "bannerimage"
    }
}

struct BrandBanner: Codable {

    let id: Int?
    let storeId: String?
    let imageURL: String?
    let status: String?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {

        case id
        case storeId = "store_id"
        case imageURL = "image_url"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
