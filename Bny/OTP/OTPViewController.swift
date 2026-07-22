//
//  OTPViewController.swift
//  Bny
//
//  Created by Abirami on 25/05/26.
//

import UIKit
import Foundation
import CoreLocation

class OTPViewController: UIViewController,CLLocationManagerDelegate {

    // MARK: - OUTLETS

    @IBOutlet weak var resendLbl: UILabel!
    @IBOutlet weak var checkMgsLbl: UILabel!
    @IBOutlet weak var numberLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var otpView1: UIView!
    @IBOutlet weak var otpView2: UIView!
    @IBOutlet weak var otpView3: UIView!
    @IBOutlet weak var otpView4: UIView!
    @IBOutlet weak var otpView5: UIView!

    @IBOutlet weak var otpTF1: UITextField!
    @IBOutlet weak var otpTF2: UITextField!
    @IBOutlet weak var otpTF3: UITextField!
    @IBOutlet weak var otpTF4: UITextField!
    @IBOutlet weak var otpTF5: UITextField!

    @IBOutlet weak var resendBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!

    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!

    // MARK: - VARIABLES

    private var resendTimer: Timer?
    private var remainingSeconds = 30
    let loginViewModel = LoginViewModel()
    
    var otpFields: [UITextField] = []
    var countryCode = ""
    var mobileNumber = ""
    var responseOTP = ""
    var name = ""
    var dob = ""
    var gender = ""
    var referralCode = ""
    var cameFrom = ""
    var address = ""
    var picture = ""
    
    var viewModel = OTPViewModel()
    
    var timer: Timer?

    var totalTime = 30

    // MARK: - LIFE CYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        self.loginViewModel.delegate = self
        self.setupUI()
        self.setupOTPFields()
        self.startResendTimer()
        self.setupTapGesture()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.submitBtn.applyButtonRedGradient()
    }

    // MARK: - SETUP UI

    func setUpLabelText() {
        self.titleLabel.text = AppStrings.OTP
        self.subTitleLbl.text = AppStrings.OTP_Message
        self.numberLbl.text =  self.countryCode + " " + self.mobileNumber
        self.checkMgsLbl.text = AppStrings.OTP_Message_Sub
        self.resendLbl.text = AppStrings.Resend_OTP
    }
    
    func setupUI() {
        AlertManager.showAlert(on: self, message: self.responseOTP)
        self.setUpLabelText()
        //signup
        let attributdString = NSAttributedString(
            string: "Sign Up",
            attributes: [
                .underlineStyle:
                    NSUnderlineStyle.single.rawValue
            ]
        )

        self.signupBtn.setAttributedTitle(
            attributdString,
            for: .normal
        )

        // Submit Button
        self.submitBtn.layer.cornerRadius = 20

        self.submitBtn.clipsToBounds = true

        // OTP Views
        let otpViews = [
            self.otpView1,
            self.otpView2,
            self.otpView3,
            self.otpView4,
            self.otpView5
        ]

        otpViews.forEach { view in
            view?.applyGlassBackground()
            view?.layer.cornerRadius = 14
            view?.layer.borderWidth = 1.5
//            view?.backgroundColor = .clear
            view?.layer.borderColor =
            UIColor.whiteClr.withAlphaComponent(0.2).cgColor
          
            
        }

        // OTP TextFields
        self.otpFields = [
            self.otpTF1,
            self.otpTF2,
            self.otpTF3,
            self.otpTF4,
            self.otpTF5
        ]

        self.otpFields.forEach { field in

            field.delegate = self
            field.overrideUserInterfaceStyle = .dark
            field.tintColor = .white
            field.textAlignment = .center

            field.textColor = .white
            field.alpha = 1.0
            field.attributedText = nil
            field.font = UIFont.poppinsBold(size: 24)

            field.keyboardType = .numbersAndPunctuation

            field.returnKeyType = .done

            field.tintColor = .white

            field.backgroundColor = .clear
        }

        let fullText = "Resend in \(self.totalTime)s"

        let attributedString =
        NSMutableAttributedString(
            string: fullText
        )

        attributedString.addAttribute(
            .foregroundColor,
            value: UIColor.white.withAlphaComponent(0.7),
            range: NSRange(
                location: 0,
                length: 10
            )
        )

        attributedString.addAttribute(
            .foregroundColor,
            value: UIColor.bnyRed,
            range: NSRange(
                location: 10,
                length: "\(self.totalTime)s".count
            )
        )

        self.resendBtn.setAttributedTitle(
            attributedString,
            for: .normal
        )
    }
    
    func highlightActiveOTPView(_ textField: UITextField) {

        let otpViews = [
            otpView1,
            otpView2,
            otpView3,
            otpView4,
            otpView5
        ]

        otpViews.forEach {
            $0?.layer.borderColor =
            UIColor.whiteClr.withAlphaComponent(0.4).cgColor
        }

        switch textField {

        case otpTF1:
            otpView1.layer.borderColor = UIColor.whiteClr.cgColor

        case otpTF2:
            otpView2.layer.borderColor = UIColor.whiteClr.cgColor

        case otpTF3:
            otpView3.layer.borderColor = UIColor.whiteClr.cgColor

        case otpTF4:
            otpView4.layer.borderColor = UIColor.whiteClr.cgColor

        case otpTF5:
            otpView5.layer.borderColor = UIColor.whiteClr.cgColor

        default:
            break
        }
    }

    // MARK: - OTP SETUP

    func setupOTPFields() {

        self.otpTF1.becomeFirstResponder()
    }
    
    func startResendTimer() {

        resendTimer?.invalidate()
        remainingSeconds = 30

        updateResendText()

        resendTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in

            guard let self = self else {
                timer.invalidate()
                return
            }

            self.remainingSeconds -= 1

            if self.remainingSeconds > 0 {

                self.updateResendText()

            } else {

                timer.invalidate()
                self.showResendOTP()
            }
        }
    }
    
    private func updateResendText() {

        let normalText = "Didn't get the OTP? Resend SMS in "
        let secondText = "\(remainingSeconds)s"

        let attributed = NSMutableAttributedString(
            string: normalText + secondText
        )

        attributed.addAttribute(
            .foregroundColor,
            value: UIColor.systemRed,
            range: NSRange(
                location: normalText.count,
                length: secondText.count
            )
        )

        resendLbl.attributedText = attributed
        resendLbl.isUserInteractionEnabled = false
    }
    
    private func showResendOTP() {

        let normalText = "Didn't get the OTP? "
        let clickText = "Resend OTP"

        let attributed = NSMutableAttributedString(
            string: normalText + clickText
        )

        attributed.addAttribute(
            .foregroundColor,
            value: UIColor.systemRed,
            range: NSRange(
                location: normalText.count,
                length: clickText.count
            )
        )

        resendLbl.attributedText = attributed
        resendLbl.isUserInteractionEnabled = true

        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(resendOTPClicked)
        )

        resendLbl.gestureRecognizers?.removeAll()
        resendLbl.addGestureRecognizer(tap)
    }
    
    @objc
    private func resendOTPClicked() {
        self.loginViewModel.login(mobile: self.mobileNumber, countryCode: self.countryCode, entry: self.cameFrom)
//        callLoginApi()
    }
    
    deinit {
        
        resendTimer?.invalidate()
    }
    
    

    // MARK: - TIMER
//    func updateResendText() {
//
//        let fullText = "Resend in \(totalTime)s"
//
//        let attributed =
//        NSMutableAttributedString(string: fullText)
//
//        attributed.addAttribute(
//            .foregroundColor,
//            value: UIColor.white.withAlphaComponent(0.7),
//            range: NSRange(location: 0, length: 10)
//        )
//
//        attributed.addAttribute(
//            .foregroundColor,
//            value: UIColor.bnyRed,
//            range: NSRange(
//                location: 10,
//                length: "\(totalTime)s".count
//            )
//        )
//
//        resendBtn.setAttributedTitle(
//            attributed,
//            for: .normal
//        )
//    }
    
//    func startResendTimer() {
//
//        self.resendBtn.isEnabled = false
//        self.updateResendText()
//        self.timer?.invalidate()
//        self.timer = Timer.scheduledTimer(
//                timeInterval: 1,
//                target: self,
//                selector: #selector(self.updateTimer),
//                userInfo: nil,
//                repeats: true
//            )
//    }
    
    @objc func updateTimer() {
        
        totalTime -= 1
        updateResendText()
        if totalTime == 0 {
            timer?.invalidate()
            resendBtn.isEnabled = true
            resendBtn.setTitle(
                "Resend",
                for: .normal
            )
            resendBtn.setTitleColor(
                .bnyRed,
                for: .normal
            )
        }
    }

    // MARK: - BUTTON ACTIONS
    @IBAction func backBtnTapped(
        _ sender: UIButton
    ) {

        self.navigationController?.popViewController(
            animated: true
        )
    }
    
    @IBAction func signupBtnTapped(
        _ sender: UIButton
    ) {

        print("Navigate Signup Screen")

        let vc = self.storyboard?.instantiateViewController(
            withIdentifier: "SignUpViewController"
        ) as! SignUpViewController
    
        self.navigationController?.pushViewController(
            vc,
            animated: true
        )
    }

    @IBAction func resendBtnTapped(
        _ sender: UIButton
    ) {

        // Resend OTP API Call

        self.otpFields.forEach {
              $0.text = ""
          }
        self.otpTF1.becomeFirstResponder()
        self.totalTime = 30
        self.startResendTimer()
    }

    @IBAction func submitBtnTapped(
        _ sender: UIButton
    )  {
        self.callOTPApi()
    }
    
    func callOTPApi(isFrom: String = "") {
        
        let enteredOTP =
        self.otpTF1.text! +
        self.otpTF2.text! +
        self.otpTF3.text! +
        self.otpTF4.text! +
        self.otpTF5.text!

        if enteredOTP.count < 5 {

            AlertManager.showAlert(on: self, message: "Enter Complete OTP")

            return
        }

        if enteredOTP != self.responseOTP {

            AlertManager.showAlert(on: self, message: "Invalid OTP")

            self.otpFields.forEach {
                $0.text = ""
            }

            self.otpTF1.becomeFirstResponder()

            return
        }
        if self.cameFrom == "signin" {
            self.viewModel.generateToken(mobile: self.mobileNumber, otp: enteredOTP, countryCode: self.countryCode)
        } else if self.cameFrom == "signup" {
            LocationManager.shared.getCurrentAddress { address in

                print(address ?? "")

                // Signup API call

                let request = SignupRequestModel(
                    mobile: self.mobileNumber,
                    name: self.name,
                    address: address ?? "",
                    dob: self.dob,
                    referralCode: self.referralCode,
                    deviceId: DeviceInfo.deviceId,
                    deviceToken: "Dummy",
                    gender: self.gender,
                    password: self.responseOTP,
                    deviceType: "ios",
                    picture: self.picture,
                    countryCode: self.countryCode
                )
                
                self.viewModel.signUp(request: request)
            }
        }

    }

    // MARK: - KEYBOARD

    func setupTapGesture() {

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(self.dismissKeyboard)
        )

        tapGesture.cancelsTouchesInView = false

        self.view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard() {
        let otpViews = [
            otpView1,
            otpView2,
            otpView3,
            otpView4,
            otpView5
        ]

        otpViews.forEach {
            $0?.layer.borderColor = UIColor.whiteClr.withAlphaComponent(0.2).cgColor
        }
        self.view.endEditing(true)
    }
}


extension OTPViewController: LoginViewModelDelegate {
    
    func didReceiveLoginOTP() {
        
        print("OTP",self.loginViewModel.otp ?? 0)
        self.responseOTP = String(self.loginViewModel.otp ?? 0)
        self.otpFields.forEach {
              $0.text = ""
          }
        self.otpTF1.becomeFirstResponder()
        self.totalTime = 30
        self.startResendTimer()
    }
    
    func didReceiveLoginError(_ message: String) {
        AlertManager.showAlert(on: self, message: message)
        print(message)
    }
}

extension OTPViewController: OTPViewModelDelegate {
    func didReceiveSignup() {

        let user = self.viewModel.signupResponse

        UserSession.shared.accessToken = user?.accessToken ?? ""
        UserSession.shared.userId = String(user?.id ?? 0)
        UserSession.shared.name = user?.name ?? ""
        UserSession.shared.mobile = user?.mobile ?? ""
        UserSession.shared.gender = user?.gender ?? ""
        UserSession.shared.address = user?.address ?? ""
        UserSession.shared.dob = user?.dob ?? ""
        UserSession.shared.countryCode = user?.countryCode ?? ""
        UserSession.shared.referralCode = user?.referralCode ?? ""
        UserSession.shared.aboutUs = user?.aboutUs ?? ""
        UserSession.shared.terms = user?.terms ?? ""
        UserSession.shared.howToUse = user?.howToUse ?? ""
        UserSession.shared.picture = user?.picture ?? ""

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didReceiveUserDetails() {

        guard let user = self.viewModel.userDetails else {
            return
        }

        let session = UserSession.shared


        session.userId = String(user.id ?? 0)
        session.name = user.name ?? ""
        session.countryCode = user.countryCode ?? ""
        session.mobile = user.mobile ?? ""
        session.address = user.address ?? ""
        session.dob = user.dob ?? ""
        session.picture = user.picture ?? ""
        session.deviceType = user.deviceType ?? ""
        session.deviceId = user.deviceId ?? ""
        session.deviceToken = user.deviceToken ?? ""
        session.referralCode = user.referralCode ?? ""
        session.aboutUs = user.aboutUs ?? ""
        session.terms = user.terms ?? ""
        session.howToUse = user.howToUse ?? ""
        session.gender = user.gender ?? ""
        session.isLoggedIn = true
        
        
        let vc = self.storyboard?.instantiateViewController(
            withIdentifier: "BrandDetailViewController"
        ) as! BrandDetailViewController

        self.navigationController?.pushViewController(
            vc,
            animated: true
        )
    }
    

    func didReceiveToken() {

            
            let session = UserSession.shared
            session.accessToken = self.viewModel.tokenResponse?.accessToken ?? ""
            session.refreshToken = self.viewModel.tokenResponse?.refreshToken ?? ""
            session.tokenType = self.viewModel.tokenResponse?.tokenType ?? ""
//            UserDefaults.standard.set(response.accessToken, forKey: "AccessToken")
//            UserDefaults.standard.set(response.refreshToken, forKey: "RefreshToken")
//            UserDefaults.standard.set(response.tokenType, forKey: "TokenType")
//            UserDefaults.standard.set(response.expiresIn, forKey: "ExpiresIn")
            
            self.viewModel.getUserDetails(accessToken: session.accessToken)
        

//        let vc = self.storyboard?.instantiateViewController(
//            withIdentifier: "HomeViewController"
//        ) as! HomeViewController
//
//        self.navigationController?.pushViewController(
//            vc,
//            animated: true
//        )
    }

    func didReceiveError(_ message: String) {

        AlertManager.showAlert(on: self, message: message)
    }
}

// MARK: - TEXTFIELD DELEGATE

extension OTPViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        self.highlightActiveOTPView(textField)
    }

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {

        // Backspace Handling
        if string.isEmpty {

            textField.text = ""

            switch textField {

            case self.otpTF2:
                self.otpTF1.becomeFirstResponder()

            case self.otpTF3:
                self.otpTF2.becomeFirstResponder()

            case self.otpTF4:
                self.otpTF3.becomeFirstResponder()

            case self.otpTF5:
                self.otpTF4.becomeFirstResponder()

            default:
                break
            }

            return false
        }

        // Allow only numbers
        let allowedCharacters =
        CharacterSet.decimalDigits

        let characterSet =
        CharacterSet(charactersIn: string)

        guard allowedCharacters.isSuperset(
            of: characterSet
        ) else {

            return false
        }

        // One Digit Only
        textField.text = string

        switch textField {

        case self.otpTF1:
            self.otpTF2.becomeFirstResponder()

        case self.otpTF2:
            self.otpTF3.becomeFirstResponder()

        case self.otpTF3:
            self.otpTF4.becomeFirstResponder()

        case self.otpTF4:
            self.otpTF5.becomeFirstResponder()

        case self.otpTF5:
            self.otpTF5.resignFirstResponder()

        default:
            break
        }

        return false
    }

    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {

        textField.resignFirstResponder()

        return true
    }
}
