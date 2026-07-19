//
//  BrandListService.swift
//  Bny
//
//  Created by Abirami on 12/07/26.
//

import Foundation
import Alamofire

class BrandService {

    func getBrandList(request: BrandRequestModel,
                      completion: @escaping(Result<BrandResponse, NetworkError>) -> Void) {

        APIManager.shared.request(APIEndPoints.storeList,
                                  method: .get,
                                  parameters: request.toDictionary(),
                                  responseModel: BrandResponse.self) { result in

            completion(result)
        }
    }
}
