//
//  LoginEntity.swift
//  Bny
//
//  Created by Abirami on 17/07/26.
//

import Foundation

struct LoginRequestModel: Encodable {

    let mobile: String
    let entry: String
    let countryCode: String

    enum CodingKeys: String, CodingKey {

        case mobile
        case entry
        case countryCode = "country_code"
    }
}

typealias LoginResponse = BaseResponse<LoginResponseModel>

struct LoginResponseModel: Codable {

    let otp: Int?

    enum CodingKeys: String, CodingKey {

        case otp
    }
}
