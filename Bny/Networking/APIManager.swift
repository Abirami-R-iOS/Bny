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

        print("\n================ API REQUEST ================")
        print("URL        :", url)
        print("Method     :", method.rawValue)
        print("Headers    :", headers ?? [:])

        if let parameters = parameters,
           let data = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted),
           let json = String(data: data, encoding: .utf8) {
            print("Parameters :\n\(json)")
        } else {
            print("Parameters :", parameters ?? [:])
        }

        print("=============================================\n")

        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoding: method == .get ? URLEncoding.default : JSONEncoding.default,
                   headers: headers)
        .validate()
        .responseData { response in

            print("\n================ API RESPONSE ================")
            print("URL         :", response.request?.url?.absoluteString ?? "")
            print("Status Code :", response.response?.statusCode ?? 0)
            print("ContentType :", response.response?.mimeType ?? "")

            if let data = response.data,
               let raw = String(data: data, encoding: .utf8) {
                print("Raw Response:\n\(raw)")
            }

            print("==============================================\n")

            switch response.result {

            case .success(let data):

                do {

                    let decoder = JSONDecoder()
                    let value = try decoder.decode(responseModel, from: data)

                    completion(.success(value))

                } catch {

                    print("\n************ DECODING ERROR ************")

                    if let decodingError = error as? DecodingError {

                        switch decodingError {

                        case .keyNotFound(let key, let context):
                            print("❌ Missing Key :", key.stringValue)
                            print("Reason :", context.debugDescription)

                        case .typeMismatch(let type, let context):
                            print("❌ Type Mismatch :", type)
                            print("Reason :", context.debugDescription)

                        case .valueNotFound(let type, let context):
                            print("❌ Value Not Found :", type)
                            print("Reason :", context.debugDescription)

                        case .dataCorrupted(let context):
                            print("❌ Data Corrupted :", context.debugDescription)

                        @unknown default:
                            print(error)
                        }

                    } else {
                        print(error)
                    }

                    print("***************************************\n")

                    completion(.failure(.serverError(error.localizedDescription)))
                }

            case .failure(let error):

                print("❌ Request Failed :", error.localizedDescription)
                completion(.failure(.serverError(error.localizedDescription)))
            }
        }
    }
    
    func authorizedHeaders() -> HTTPHeaders {

        return [
            "Authorization": "Bearer \(UserSession.shared.accessToken)",
            "Accept": "application/json"
        ]
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

        print("\n================ API REQUEST ================")
        print("URL        :", url)
        print("Method     :", method.rawValue)
        print("Headers    :", headers ?? [:])

        if let parameters = parameters,
           let data = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted),
           let json = String(data: data, encoding: .utf8) {
            print("Parameters :\n\(json)")
        } else {
            print("Parameters :", parameters ?? [:])
        }

        if image != nil {
            print("Image       : Yes")
        } else {
            print("Image       : No")
        }

        print("=============================================\n")

        AF.upload(
            multipartFormData: { multipart in

                parameters?.forEach { key, value in

                    guard key != "picture" else { return }
                    
                    
                    multipart.append(
                        Data("\(value)".utf8),
                        withName: key
                    )
                }

                if let image = image,
                   let imageData = image.jpegData(compressionQuality: 0.8) {

                    multipart.append(
                        imageData,
                        withName: "picture",
                        fileName: "profile.jpg",
                        mimeType: "image/jpeg"
                    )
                }

            },
            to: url,
            method: method,
            headers: headers
        )
        .validate()
        .responseData { response in

            print("\n================ API RESPONSE ================")
            print("URL         :", response.request?.url?.absoluteString ?? "")
            print("Status Code :", response.response?.statusCode ?? 0)
            print("ContentType :", response.response?.mimeType ?? "")

            if let data = response.data,
               let raw = String(data: data, encoding: .utf8) {
                print("Raw Response:\n\(raw)")
            }

            print("==============================================\n")

            switch response.result {

            case .success(let data):

                do {

                    let decoder = JSONDecoder()
                    let value = try decoder.decode(responseModel, from: data)

                    completion(.success(value))

                } catch {

                    print("\n************ DECODING ERROR ************")

                    if let decodingError = error as? DecodingError {

                        switch decodingError {

                        case .keyNotFound(let key, let context):
                            print("❌ Missing Key :", key.stringValue)
                            print("Reason :", context.debugDescription)

                        case .typeMismatch(let type, let context):
                            print("❌ Type Mismatch :", type)
                            print("Reason :", context.debugDescription)

                        case .valueNotFound(let type, let context):
                            print("❌ Value Not Found :", type)
                            print("Reason :", context.debugDescription)

                        case .dataCorrupted(let context):
                            print("❌ Data Corrupted :", context.debugDescription)

                        @unknown default:
                            print(error)
                        }

                    } else {

                        print(error)
                    }

                    print("***************************************\n")

                    completion(.failure(.decodingError(error.localizedDescription)))

                }

            case .failure(let error):

                print("❌ Request Failed :", error.localizedDescription)

                completion(.failure(.serverError(error.localizedDescription)))
            }
        }
    }
}
