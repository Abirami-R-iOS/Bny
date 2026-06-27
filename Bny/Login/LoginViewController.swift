//
//  LoginViewController.swift
//  Bny
//
//  Created by Abirami on 24/05/26.
//

import UIKit
import CountryPickerView

class LoginViewController: UIViewController {
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var phoneContainerView: UIView!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var countryBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    
    // MARK: - VARIABLES
    
    private let gradientLayer = CAGradientLayer()
    let countryPickerView = CountryPickerView()
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.setUpTextField()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.continueBtn.applyButtonRedGradient()
        self.phoneContainerView.applyGlassBackground()
        self.googleBtn.applyPremiumNavyCard()
    }
    
    // MARK: - SETUP UI
    
    private func setupUI() {
        self.phoneTextField.keyboardType = .numberPad
        //SignUp
        let attributedString = NSAttributedString(
            string: "Sign Up",
            attributes: [
                .underlineStyle:
                    NSUnderlineStyle.single.rawValue
            ]
        )

        signupBtn.setAttributedTitle(
            attributedString,
            for: .normal
        )
        
        // Background Image
        bgImageView.contentMode = .scaleAspectFill
        
        // Overlay
        //        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.45)
        
        // Bring logo above overlay
        view.bringSubviewToFront(logoImageView)
        
        // Phone Container
        phoneContainerView.layer.cornerRadius = 20
        phoneContainerView.layer.borderWidth = 1
        
        phoneContainerView.layer.borderColor =
        UIColor.white.withAlphaComponent(0.2).cgColor
        
        //        phoneContainerView.backgroundColor =
        //            UIColor.white.withAlphaComponent(0.08)
        
        // Continue Button
        continueBtn.layer.cornerRadius = 20
        continueBtn.clipsToBounds = true
        
        // Google Button
        googleBtn.layer.cornerRadius = 20
        googleBtn.backgroundColor =
        UIColor(hex: "#10192A")
        
        googleBtn.layer.borderWidth = 1
        
        googleBtn.layer.borderColor =
        UIColor.white.withAlphaComponent(0.1).cgColor
        
        countryPickerView.delegate = self

        let country = countryPickerView.selectedCountry
        let flagImage = country.flag.withRenderingMode(.alwaysOriginal)
        countryBtn.setImage(flagImage, for: .normal)
        countryBtn.tintColor = .whiteClr
        countryBtn.setTitle(
            " \(country.phoneCode)",
            for: .normal
        )
    }
    
    func setUpTextField() {
        self.phoneTextField.keyboardType = .numbersAndPunctuation
        phoneTextField.enablesReturnKeyAutomatically = true
        self.phoneTextField.textColor = .white
        
        self.phoneTextField.tintColor = .white
        
        self.phoneTextField.attributedPlaceholder = NSAttributedString(
            string: "Enter Phone Number",
            attributes: [
                .foregroundColor:
                    UIColor.white.withAlphaComponent(0.7)
            ]
        )
        
        self.phoneTextField.delegate = self
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )

        view.addGestureRecognizer(tapGesture)
//        self.phoneTextField.addDoneButton(
//            target: self,
//            action: #selector(doneButtonTapped)
//        )
    }
    @objc func dismissKeyboard() {

        view.endEditing(true)
    }
    @IBAction func countryBtnTapped(_ sender: UIButton) {

        self.countryPickerView.showCountriesList(
            from: self
        )
    }
    
    @IBAction func continueBtnTapped(_ sender: UIButton) {

        guard let phone =
                phoneTextField.text,
              !phone.isEmpty else {
            AlertManager.showAlert(
                on: self,
                title: "Error",
                message: "Enter Phone Number"
            )
           
            return
        }

        if phone.count < 10 {
            AlertManager.showAlert(
                on: self,
                title: "Error",
                message: "Enter Valid Phone Number"
            )
            return
        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
        vc.countryCode = self.countryBtn.titleLabel?.text ?? ""
        vc.mobileNumber = self.phoneTextField.text ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
//    func showAlert(message: String) {
//
//        let alert = UIAlertController(
//            title: "Bny",
//            message: message,
//            preferredStyle: .alert
//        )
//
//        alert.addAction(
//            UIAlertAction(
//                title: "OK",
//                style: .default
//            )
//        )
//
//        present(alert, animated: true)
//    }
    
    @IBAction func signupBtnTapped(_ sender: UIButton) {

//        print("Navigate Signup Screen")

        // Example Navigation

        let vc = storyboard?.instantiateViewController(
            withIdentifier: "SignUpViewController"
        ) as! SignUpViewController
    
        navigationController?.pushViewController(
            vc,
            animated: true
        )
    }
    
    @IBAction func googleBtnTapped(_ sender: UIButton) {

        UIView.animate(withDuration: 0.1) {

            sender.transform =
                CGAffineTransform(scaleX: 0.96, y: 0.96)

        } completion: { _ in

            UIView.animate(withDuration: 0.1) {

                sender.transform = .identity
            }
        }

        print("Google Login Tapped")
    }
}

extension LoginViewController:
CountryPickerViewDelegate {

    func countryPickerView(
        _ countryPickerView: CountryPickerView,
        didSelectCountry country: Country
    ) {

        countryBtn.configuration = nil

        let flagImage = country.flag.withRenderingMode(.alwaysOriginal)

        countryBtn.setImage(flagImage, for: .normal)

        countryBtn.setTitle(
            " \(country.phoneCode)",
            for: .normal
        )
        countryBtn.tintColor = .whiteClr

//        countryBtn.semanticContentAttribute = .forceLeftToRight

//        countryBtn.imageEdgeInsets = UIEdgeInsets(
//            top: 0,
//            left: -8,
//            bottom: 0,
//            right: 0
//        )

//        countryBtn.titleEdgeInsets = UIEdgeInsets(
//            top: 0,
//            left: 8,
//            bottom: 0,
//            right: 0
//        )
    }
}


extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {

        textField.resignFirstResponder()

        return true
    }

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {

        // Allow only numbers
        let allowedCharacters = CharacterSet.decimalDigits

        let characterSet = CharacterSet(
            charactersIn: string
        )

        guard allowedCharacters.isSuperset(
            of: characterSet
        ) else {

            return false
        }

        // Current Text
        let currentText =
            textField.text ?? ""

        guard let stringRange =
                Range(range, in: currentText) else {

            return false
        }

        let updatedText = currentText.replacingCharacters(
            in: stringRange,
            with: string
        )

        // Limit to 10 digits
        return updatedText.count <= 10
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        
    }
    @objc func doneButtonTapped() {

        view.endEditing(true)
    }
    
}
