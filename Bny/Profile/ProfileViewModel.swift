//
//  ProfileViewModel.swift
//  Bny
//
//  Created by Abirami on 17/07/26.
//

import Foundation
final class LogoutViewModel {

    private let service: LogoutServiceProtocol

    init(service: LogoutServiceProtocol = LogoutService()) {
        self.service = service
    }

    func logout(
        completion: @escaping (Result<LogoutResponseModel, NetworkError>) -> Void
    ) {

        self.service.logout(completion: completion)
    }
}
