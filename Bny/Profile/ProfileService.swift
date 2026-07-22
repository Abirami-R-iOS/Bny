//
//  ProfileService.swift
//  Bny
//
//  Created by Abirami on 17/07/26.
//

import Foundation
import Alamofire


protocol LogoutServiceProtocol {
    func logout(
        completion: @escaping (Result<LogoutResponseModel, NetworkError>) -> Void
    )
}

final class LogoutService: LogoutServiceProtocol {

    func logout(
        completion: @escaping (Result<LogoutResponseModel, NetworkError>) -> Void
    ) {

        APIManager.shared.request(
            APIEndPoints.logout,
            method: .post,
            headers: APIManager.shared.authorizedHeaders(),
            responseModel: LogoutResponseModel.self,
            completion: completion
        )
    }
}
