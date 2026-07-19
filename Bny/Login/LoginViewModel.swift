//
//  LoginViewModel.swift
//  Bny
//
//  Created by Abirami on 17/07/26.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {

    func didReceiveLoginOTP()

    func didReceiveLoginError(_ message: String)
}

class LoginViewModel {

    weak var delegate: LoginViewModelDelegate?

    private let service = LoginService()

    var otp: Int?

    func login(mobile: String,
               countryCode: String, entry: String = "signin") {

        let request = LoginRequestModel(mobile: mobile,
                                        entry: entry,
                                        countryCode: countryCode)

        service.login(request: request) { [weak self] result in

            switch result {

            case .success(let response):
                // Ensure API indicates success; otherwise, surface the message
                if response.status != "Success" {
                    DispatchQueue.main.async {
                        self?.delegate?.didReceiveLoginError(response.message ?? "Something went wrong")
                    }
                    return
                }

                // Capture OTP if present
                self?.otp = response.data?.otp

                DispatchQueue.main.async {

                    self?.delegate?.didReceiveLoginOTP()
                }

            case .failure(let error):

                DispatchQueue.main.async {

                    self?.delegate?.didReceiveLoginError(error.localizedDescription)
                }
            }
        }
    }
}

