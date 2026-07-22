//
//  ProfileEntity.swift
//  Bny
//
//  Created by Abirami on 17/07/26.
//

import Foundation

typealias UserDetailsResponse = BaseResponse<UserDetailsData>

struct UserDetailsData: Codable {

    let id: Int?
    let name: String?
    let countryCode: String?
    let mobile: String?
    let address: String?
    let dob: String?
    let picture: String?
    let deviceType: String?
    let deviceId: String?
    let deviceToken: String?
    let referralCode: String?
    let aboutUs: String?
    let terms: String?
    let howToUse: String?
    let gender: String?

    enum CodingKeys: String, CodingKey {

        case id
        case name
        case countryCode = "country_code"
        case mobile
        case address
        case dob
        case picture
        case deviceType = "device_type"
        case deviceId = "device_id"
        case deviceToken = "device_token"
        case referralCode = "referral_code"
        case aboutUs = "about_us"
        case terms
        case howToUse = "how_to_use"
        case gender
    }
}

struct LogoutResponseModel: Codable {
    let message: String?
}
