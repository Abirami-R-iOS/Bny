//
//  HomeService.swift
//  Bny
//
//  Created by Abirami on 12/07/26.
//

import Foundation
import Alamofire

final class HomeService {

    func getCategories(request: CategoryRequest,
                       completion: @escaping(Result<CategoryResponse, NetworkError>) -> Void) {

        APIManager.shared.request(
            APIEndPoints.categories,
            method: .get,
            parameters: request.toDictionary(),
            responseModel: CategoryResponse.self,
            completion: completion
        )
    }
}
