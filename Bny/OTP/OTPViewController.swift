//
//  OTPViewController.swift
//  Bny
//
//  Created by Abirami on 25/05/26.
//

import UIKit
import Foundation

class OTPViewController: UIViewController {

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

    var otpFields: [UITextField] = []
    var countryCode = ""
    var mobileNumber = ""

    var timer: Timer?

    var totalTime = 30

    // MARK: - LIFE CYCLE

    override func viewDidLoad() {
        super.viewDidLoad()

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

    // MARK: - TIMER
    func updateResendText() {

        let fullText = "Resend in \(totalTime)s"

        let attributed =
        NSMutableAttributedString(string: fullText)

        attributed.addAttribute(
            .foregroundColor,
            value: UIColor.white.withAlphaComponent(0.7),
            range: NSRange(location: 0, length: 10)
        )

        attributed.addAttribute(
            .foregroundColor,
            value: UIColor.bnyRed,
            range: NSRange(
                location: 10,
                length: "\(totalTime)s".count
            )
        )

        resendBtn.setAttributedTitle(
            attributed,
            for: .normal
        )
    }
    
    func startResendTimer() {

        self.resendBtn.isEnabled = false
        self.updateResendText()
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(
                timeInterval: 1,
                target: self,
                selector: #selector(self.updateTimer),
                userInfo: nil,
                repeats: true
            )
    }
    
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
    ) {
        let vc = self.storyboard?.instantiateViewController(
            withIdentifier: "HomeViewController"
        ) as! HomeViewController
    
        self.navigationController?.pushViewController(
            vc,
            animated: true
        )

        let otp =
        self.otpTF1.text! +
        self.otpTF2.text! +
        self.otpTF3.text! +
        self.otpTF4.text! +
        self.otpTF5.text!

        if otp.count < 5 {

            self.showAlert(
                message: "Enter Complete OTP"
            )

        } else {

            print("OTP:", otp)
        }
    }

    // MARK: - ALERT

    func showAlert(message: String) {

        let alert = UIAlertController(
            title: "Bny",
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default
            )
        )

        self.present(alert, animated: true)
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
