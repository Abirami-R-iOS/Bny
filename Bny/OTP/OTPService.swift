//
//  OTPService.swift
//  Bny
//
//  Created by Abirami on 17/07/26.
//

import Foundation
import Alamofire

class OTPService {

    func generateToken(request: OTPTokenRequestModel,
                       completion: @escaping(Result<OTPTokenResponseModel, NetworkError>) -> Void) {

        APIManager.shared.request(APIEndPoints.Otp,
                                  method: .post,
                                  parameters: request.toDictionary(),
                                  responseModel: OTPTokenResponseModel.self) { result in

            completion(result)
        }
    }
    
    func getUserDetails(accessToken: String,
                        completion: @escaping(Result<UserDetailsResponse, NetworkError>) -> Void) {

        let headers: HTTPHeaders = [

            "Authorization": "Bearer \(accessToken)"
        ]

        APIManager.shared.request(
            APIEndPoints.userDetails,
            method: .get,
            headers: headers,
            responseModel: UserDetailsResponse.self
        ) { result in

            completion(result)
        }
    }
}
