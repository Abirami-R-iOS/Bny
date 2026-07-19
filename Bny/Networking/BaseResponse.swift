//
//  BaseResponse.swift
//  Bny
//
//  Created by Abirami on 12/07/26.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {

    let status: String?
    let message: String?
    let data: T?
}
