//
//  FavouriteService.swift
//  Bny
//
//  Created by Abirami on 21/07/26.
//

import Foundation
import Alamofire

final class FavouriteService {

    func getFavourites(request: FavouriteRequest,
                       completion: @escaping(Result<FavouriteResponse, NetworkError>) -> Void) {

        APIManager.shared.request(
            APIEndPoints.categories,
            method: .get,
            parameters: request.toDictionary(),
            headers: APIManager.shared.authorizedHeaders(),
            responseModel: FavouriteResponse.self,
            completion: completion
        )
    }
}

