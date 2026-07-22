//
//  EditProfileEntity.swift
//  Bny
//
//  Created by Abirami on 22/07/26.
//

import Foundation

struct UpdateProfileRequestModel: Codable {

    let name: String
    let mobile: String
    let gender: String
    let address: String
    let dob: String
    let picture: String
    let countryCode: String

    enum CodingKeys: String, CodingKey {
        case name
        case mobile
        case gender
        case address
        case dob
        case picture
        case countryCode = "country_code"
    }
}

struct UpdateProfileResponseModel: Codable {

    let status: String?
    let message: String?
    let data: UpdateProfileData?

    enum CodingKeys: String, CodingKey {
        case status
        case message
        case data
    }
}

struct UpdateProfileData: Codable {

    let name: String?
    let mobile: String?
    let picture: String?
    let address: String?
    let dob: String?
    let gender: String?

    enum CodingKeys: String, CodingKey {
        case name
        case mobile
        case picture
        case address
        case dob
        case gender
    }
}
