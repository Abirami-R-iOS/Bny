//
//  APIManager.swift
//  Bny
//
//  Created by Abirami on 12/07/26.
//

import Foundation
import Alamofire
import UIKit

final class APIManager {

    static let shared = APIManager()

    private init() { }

    func request<T: Decodable>(_ endPoint: String,
                               method: HTTPMethod = .get,
                               parameters: Parameters? = nil,
                               headers: HTTPHeaders? = nil,
                               responseModel: T.Type,
                               completion: @escaping(Result<T, NetworkError>) -> Void) {

        let url = APIConstants.baseURL + endPoint

        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoding: method == .get ? URLEncoding.default : JSONEncoding.default,
                   headers: headers)
        .validate()
        .responseDecodable(of: responseModel) { response in

            switch response.result {

            case .success(let value):

                completion(.success(value))

            case .failure(let error):

                completion(.failure(.serverError(error.localizedDescription)))
            }
        }
    }
    

    func upload<T: Decodable>(
        _ endPoint: String,
        method: HTTPMethod = .post,
        parameters: Parameters? = nil,
        image: UIImage? = nil,
        headers: HTTPHeaders? = nil,
        responseModel: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {

        let url = APIConstants.baseURL + endPoint

        print("======================================")
        print("UPLOAD URL : \(url)")
        print("PARAMETERS : \(parameters ?? [:])")
        print("======================================")

        print("Original URL :", url)
        AF.upload(
            multipartFormData: { multipart in

                parameters?.forEach { key, value in

                    guard key != "picture" else { return }

                    if let stringValue = value as? String {

                        multipart.append(
                            Data(stringValue.utf8),
                            withName: key
                        )

                    } else {

                        multipart.append(
                            Data("\(value)".utf8),
                            withName: key
                        )
                    }
                }

                if let image = image,
                   let imageData = image.jpegData(compressionQuality: 0.8) {

                    multipart.append(
                        imageData,
                        withName: "picture",
                        fileName: "profile.jpg",
                        mimeType: "image/jpeg"
                    )

                    print("Image Added")
                }

            },
            to: url,
            method: method,
            headers: headers
        )
        .validate(statusCode: 200...299)
        .responseData { response in

            print("Request URL")
                print(response.request?.url?.absoluteString ?? "")
            
            print("Response URL")
                print(response.response?.url?.absoluteString ?? "")
            
            print("======================================")
            print("STATUS : \(response.response?.statusCode ?? 0)")

            if let data = response.data {

                print(String(data: data, encoding: .utf8) ?? "")
            }

            print("======================================")

            switch response.result {

            case .success(let data):

                do {

                    let decoder = JSONDecoder()

                    let result = try decoder.decode(
                        responseModel,
                        from: data
                    )

                    completion(.success(result))

                } catch {

                    print("Decode Error :", error)

                    completion(
                        .failure(
                            .decodingError(error.localizedDescription)
                        )
                    )
                }

            case .failure(let error):

                completion(
                    .failure(
                        .serverError(error.localizedDescription)
                    )
                )
            }

        }

    }
}
