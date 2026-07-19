//
//  OTPEntity.swift
//  Bny
//
//  Created by Abirami on 17/07/26.
//

import Foundation
import UIKit

struct OTPTokenRequestModel: Encodable {

    let grantType: String
    let clientId: String
    let clientSecret: String
    let username: String
    let password: String
    let countryCode: String

    enum CodingKeys: String, CodingKey {

        case grantType = "grant_type"
        case clientId = "client_id"
        case clientSecret = "client_secret"
        case username
        case password
        case countryCode = "country_code"
    }
}

struct OTPTokenResponseModel: Codable {

    let tokenType: String?
    let expiresIn: Int?
    let accessToken: String?
    let refreshToken: String?

    enum CodingKeys: String, CodingKey {

        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}


struct DeviceInfo {

    static var deviceId: String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
}
