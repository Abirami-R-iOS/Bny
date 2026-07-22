//
//  OTPViewModel.swift
//  Bny
//
//  Created by Abirami on 17/07/26.
//
import UIKit
import Foundation

protocol OTPViewModelDelegate: AnyObject {
    
    func didReceiveToken()
    func didReceiveUserDetails()
    func didReceiveSignup()
    func didReceiveError(_ message: String)
}

class OTPViewModel {

    weak var delegate: OTPViewModelDelegate?
    
    var userDetails: UserDetailsData?

    private let service = OTPService()

    private let signupService = SignUpService()
    
    var tokenResponse: OTPTokenResponseModel?
    var signupResponse: SignupResponseModel?

    func generateToken(mobile: String,
                       otp: String,
                       countryCode: String) {

        let request = OTPTokenRequestModel(
            grantType: "password",
            clientId: "2",
            clientSecret: "9C1qHvt8vLSOODpr341FqDkCyT7X2nlwu2fvk10u",
            username: mobile,
            password: otp,
            countryCode: countryCode
        )

        service.generateToken(request: request) { [weak self] result in

            switch result {

            case .success(let response):

                self?.tokenResponse = response

                self?.delegate?.didReceiveToken()

            case .failure(let error):

                self?.delegate?.didReceiveError(error.localizedDescription)
            }
        }
    }
    
    func getUserDetails(accessToken: String) {

        service.getUserDetails(accessToken: accessToken) { [weak self] result in

            switch result {

            case .success(let response):

                self?.userDetails = response.data

                self?.delegate?.didReceiveUserDetails()

            case .failure(let error):

                self?.delegate?.didReceiveError(error.localizedDescription)
            }
        }
    }
    
    func signUp(request: SignupRequestModel) {

        self.signupService.signUp(request: request, image: nil) { [weak self] result in

            switch result {

            case .success(let response):

                self?.signupResponse = response.data
                self?.delegate?.didReceiveSignup()

            case .failure(let error):

                self?.delegate?.didReceiveError(error.localizedDescription)
            }
        }
    }
}
