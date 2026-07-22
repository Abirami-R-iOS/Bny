//
//  UserSession.swift
//  Bny
//
//  Created by Abirami on 17/07/26.
//

import Foundation

final class UserSession {

    static let shared = UserSession()

    private init() {}

    private let defaults = UserDefaults.standard

    var userId: String {
        get { defaults.string(forKey: "UserId") ?? "" }
        set { defaults.set(newValue, forKey: "UserId") }
    }

    var name: String {
        get { defaults.string(forKey: "UserName") ?? "" }
        set { defaults.set(newValue, forKey: "UserName") }
    }

    var countryCode: String {
        get { defaults.string(forKey: "CountryCode") ?? "" }
        set { defaults.set(newValue, forKey: "CountryCode") }
    }

    var mobile: String {
        get { defaults.string(forKey: "Mobile") ?? "" }
        set { defaults.set(newValue, forKey: "Mobile") }
    }

    var address: String {
        get { defaults.string(forKey: "Address") ?? "" }
        set { defaults.set(newValue, forKey: "Address") }
    }

    var dob: String {
        get { defaults.string(forKey: "DOB") ?? "" }
        set { defaults.set(newValue, forKey: "DOB") }
    }

    var picture: String {
        get { defaults.string(forKey: "Picture") ?? "" }
        set { defaults.set(newValue, forKey: "Picture") }
    }

    var deviceType: String {
        get { defaults.string(forKey: "DeviceType") ?? "" }
        set { defaults.set(newValue, forKey: "DeviceType") }
    }

    var deviceId: String {
        get { defaults.string(forKey: "DeviceId") ?? "" }
        set { defaults.set(newValue, forKey: "DeviceId") }
    }

    var deviceToken: String {
        get { defaults.string(forKey: "DeviceToken") ?? "" }
        set { defaults.set(newValue, forKey: "DeviceToken") }
    }

    var referralCode: String {
        get { defaults.string(forKey: "ReferralCode") ?? "" }
        set { defaults.set(newValue, forKey: "ReferralCode") }
    }

    var aboutUs: String {
        get { defaults.string(forKey: "AboutUs") ?? "" }
        set { defaults.set(newValue, forKey: "AboutUs") }
    }

    var terms: String {
        get { defaults.string(forKey: "Terms") ?? "" }
        set { defaults.set(newValue, forKey: "Terms") }
    }

    var howToUse: String {
        get { defaults.string(forKey: "HowToUse") ?? "" }
        set { defaults.set(newValue, forKey: "HowToUse") }
    }

    var gender: String {
        get { defaults.string(forKey: "Gender") ?? "" }
        set { defaults.set(newValue, forKey: "Gender") }
    }
    
    var isLoggedIn: Bool {
        get { defaults.bool(forKey: "IsLoggedIn") }
        set { defaults.set(newValue, forKey: "IsLoggedIn") }
    }

    var accessToken: String {
        get { defaults.string(forKey: "AccessToken") ?? "" }
        set { defaults.set(newValue, forKey: "AccessToken") }
    }

    var refreshToken: String {
        get { defaults.string(forKey: "RefreshToken") ?? "" }
        set { defaults.set(newValue, forKey: "RefreshToken") }
    }

    var tokenType: String {
        get { defaults.string(forKey: "TokenType") ?? "" }
        set { defaults.set(newValue, forKey: "TokenType") }
    }
    
    func clear() {

        accessToken = ""
        userId = ""
        name = ""
        mobile = ""
        gender = ""
        address = ""
        countryCode = ""
        dob = ""
        picture = ""
        tokenType = ""
        refreshToken = ""
        terms = ""
        howToUse = ""
        aboutUs = ""
        referralCode = ""
        deviceToken = ""
        deviceId = ""
        deviceType = ""

        let defaults = UserDefaults.standard

            defaults.removeObject(forKey: "accessToken")
            defaults.removeObject(forKey: "userId")
            defaults.removeObject(forKey: "name")
            defaults.removeObject(forKey: "mobile")
            defaults.removeObject(forKey: "gender")
            defaults.removeObject(forKey: "address")
            defaults.removeObject(forKey: "countryCode")
            defaults.removeObject(forKey: "dob")
            defaults.removeObject(forKey: "picture")
            defaults.removeObject(forKey: "tokenType")
            defaults.removeObject(forKey: "refreshToken")
            defaults.removeObject(forKey: "terms")
            defaults.removeObject(forKey: "howToUse")
            defaults.removeObject(forKey: "aboutUs")
            defaults.removeObject(forKey: "referralCode")
            defaults.removeObject(forKey: "deviceToken")
            defaults.removeObject(forKey: "deviceId")
            defaults.removeObject(forKey: "deviceType")
            defaults.synchronize()
    }
}
