//
//  SignUpViewModel.swift
//  Bny
//
//  Created by Abirami on 18/07/26.
//

import Foundation

protocol SignUpViewModelDelegate: AnyObject {

    func didReceiveSignUpOTP()

    func didReceiveSignUpError(_ message: String)
}

class SignUpViewModel {

    weak var delegate: SignUpViewModelDelegate?
    private let service = SignUpService()
    var otp: Int?

    func signUp(mobile: String,
               countryCode: String) {

        let request = SignUpOTPRequestModel(mobile: mobile,
                                        entry: "signup",
                                        countryCode: countryCode)

        service.signUpOTP(request: request) { [weak self] result in

            switch result {

            case .success(let response):
                // Ensure API indicates success; otherwise, surface the message
                if response.status != "Success" {
                    DispatchQueue.main.async {
                        self?.delegate?.didReceiveSignUpError(response.message ?? "Something went wrong")
                    }
                    return
                }

                // Capture OTP if present
                self?.otp = response.data?.otp

                DispatchQueue.main.async {

                    self?.delegate?.didReceiveSignUpOTP()
                }

            case .failure(let error):

                DispatchQueue.main.async {

                    self?.delegate?.didReceiveSignUpError(error.localizedDescription)
                }
            }
        }
    }
}

