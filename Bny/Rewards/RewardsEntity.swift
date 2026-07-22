//
//  RewardsEntity.swift
//  Bny
//
//  Created by Abirami on 28/06/26.
//

import Foundation

enum RewardTab {
    case rewards
    case specials
    case history

    var title: String {
        switch self {
        case .rewards: return AppStrings.Rewards_Title
        case .specials: return AppStrings.Specials
        case .history: return AppStrings.History
        }
    }
}

typealias RewardsResponse = BaseResponse<[RewardData]>

struct RewardData: Codable {

    let id: Int?
    let userId: String?
    let storeId: String?
    let rewardValue: String?
    let rewardType: String?
    let rewardDescription: String?
    let colorCode: String?
    let validity: String?
    let createdAt: String?
    let updatedAt: String?
    let store: RewardStore?

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case storeId = "store_id"
        case rewardValue = "reward_value"
        case rewardType = "reward_type"
        case rewardDescription = "reward_description"
        case colorCode = "color_code"
        case validity
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case store
    }
}

struct RewardStore: Codable {

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
    let createdAt: String?
    let updatedAt: String?

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
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
