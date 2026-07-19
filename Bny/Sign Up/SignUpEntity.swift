//
//  SignUpEntity.swift
//  Bny
//
//  Created by Abirami on 18/07/26.
//

import Foundation

struct SignUpOTPRequestModel: Encodable {

    let mobile: String
    let entry: String
    let countryCode: String

    enum CodingKeys: String, CodingKey {

        case mobile
        case entry
        case countryCode = "country_code"
    }
}

typealias SignUpOTPResponse = BaseResponse<SignUpOTPResponseModel>

struct SignUpOTPResponseModel: Codable {

    let otp: Int?

    enum CodingKeys: String, CodingKey {

        case otp
    }
}

struct SignupRequestModel: Codable {

    let mobile: String
    let name: String
    let address: String
    let dob: String
    let referralCode: String
    let deviceId: String
    let deviceToken: String
    let gender: String
    let password: String
    let deviceType: String
    let picture: String
    let countryCode: String

    enum CodingKeys: String, CodingKey {

        case mobile
        case name
        case address
        case dob
        case referralCode = "referral_code"
        case deviceId = "device_id"
        case deviceToken = "device_token"
        case gender
        case password
        case deviceType = "device_type"
        case picture
        case countryCode = "country_code"
    }
}

typealias SignupResponse = BaseResponse<SignupResponseModel>

struct SignupResponseModel: Codable {

    let id: Int?
    let name: String?
    let countryCode: String?
    let mobile: String?
    let gender: String?
    let dob: String?
    let referralCode: String?
    let address: String?
    let accessToken: String?

    enum CodingKeys: String, CodingKey {

        case id
        case name
        case countryCode = "country_code"
        case mobile
        case gender
        case dob
        case referralCode = "referral_code"
        case address
        case accessToken = "accesstoken"
    }
}

