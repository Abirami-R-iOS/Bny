//
//  EditProfileService.swift
//  Bny
//
//  Created by Abirami on 22/07/26.
//

import Foundation
import UIKit

final class EditProfileService {

    func updateProfile(
        request: UpdateProfileRequestModel,
        image: UIImage?,
        completion: @escaping (Result<UpdateProfileResponseModel, NetworkError>) -> Void
    ) {

        APIManager.shared.upload(
            APIEndPoints.updateProfile,
            parameters: request.toDictionary(),
            image: image,
            headers: APIManager.shared.authorizedHeaders(),
            responseModel: UpdateProfileResponseModel.self
        ) { result in

            completion(result)
        }
    }
}
