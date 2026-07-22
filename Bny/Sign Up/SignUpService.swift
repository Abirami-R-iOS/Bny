//
//  SignUpService.swift
//  Bny
//
//  Created by Abirami on 18/07/26.
//

import Foundation
import Alamofire
import UIKit

class SignUpService {

    func signUpOTP(request: SignUpOTPRequestModel,
               completion: @escaping(Result<SignUpOTPResponse, NetworkError>) -> Void) {

        APIManager.shared.request(APIEndPoints.signUpOTP,
                                  method: .post,
                                  parameters: request.toDictionary(),
                                  responseModel: SignUpOTPResponse.self) { result in

            completion(result)
        }
    }
    
    func signUp(request: SignupRequestModel, image: UIImage?,
                completion: @escaping(Result<SignupResponse, NetworkError>) -> Void) {

        APIManager.shared.upload(
            APIEndPoints.signUp,
            parameters: request.toDictionary(),
            image: image, // nil if no image
            responseModel: SignupResponse.self
        ) { result in

            completion(result)

        }
    }
}
