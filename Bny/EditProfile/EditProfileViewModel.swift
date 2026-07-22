//
//  EditProfileViewModel.swift
//  Bny
//
//  Created by Abirami on 22/07/26.
//

import Foundation
import UIKit
final class EditProfileViewModel {

    private let service = EditProfileService()

    func updateProfile(
        request: UpdateProfileRequestModel,
        image: UIImage?,
        completion: @escaping (Result<UpdateProfileResponseModel, NetworkError>) -> Void
    ) {

        service.updateProfile(
            request: request,
            image: image,
            completion: completion
        )
    }
}
