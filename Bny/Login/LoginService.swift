//
//  LoginService.swift
//  Bny
//
//  Created by Abirami on 17/07/26.
//

import Foundation
import Alamofire

class LoginService {

    func login(request: LoginRequestModel,
               completion: @escaping(Result<LoginResponse, NetworkError>) -> Void) {

        APIManager.shared.request(APIEndPoints.login,
                                  method: .post,
                                  parameters: request.toDictionary(),
                                  responseModel: LoginResponse.self) { result in

            completion(result)
        }
    }
}
