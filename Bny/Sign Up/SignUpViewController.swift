//
//  SignupViewController.swift
//  Bny
//
//  Created by Abirami on 25/05/26.
//

import UIKit

class SignUpViewController: UIViewController {

    // MARK: - OUTLETS

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var overlayView: UIView!

    @IBOutlet weak var logoImageView: UIImageView!

    @IBOutlet weak var nameTF: UITextField!

    @IBOutlet weak var mobileTF: UITextField!

    @IBOutlet weak var dobTF: UITextField!

    @IBOutlet weak var addressTF: UITextField!

    @IBOutlet weak var genderTF: UITextField!

    @IBOutlet weak var genderDropDownBtn: UIButton!

    @IBOutlet weak var signupBtn: UIButton!

    @IBOutlet weak var loginBtn: UIButton!

    @IBOutlet weak var nameContainerView: UIView!

    @IBOutlet weak var mobileContainerView: UIView!

    @IBOutlet weak var dobContainerView: UIView!

    @IBOutlet weak var addressContainerView: UIView!

    @IBOutlet weak var genderContainerView: UIView!

    // MARK: - VARIABLES

    let datePicker = UIDatePicker()

    let genderList = [
        "Male",
        "Female",
        "Other"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.setupTextFields()
        self.setupDatePicker()
    }
    func setupUI() {

        let containerViews = [
            self.nameContainerView,
            self.mobileContainerView,
            self.dobContainerView,
            self.addressContainerView,
            self.genderContainerView
        ]

        containerViews.forEach { view in

            view?.layer.cornerRadius = 14

            view?.layer.borderWidth = 1

            view?.layer.borderColor =
            UIColor.white.withAlphaComponent(0.5).cgColor

            view?.backgroundColor = .clear
        }

        self.signupBtn.layer.cornerRadius = 18

        self.signupBtn.clipsToBounds = true

        self.signupBtn.applyButtonRedGradient()

        let attributedString = NSAttributedString(
            string: "Login",
            attributes: [
                .underlineStyle:
                    NSUnderlineStyle.single.rawValue,
                .foregroundColor:
                    UIColor.gradientTop
            ]
        )

        self.loginBtn.setAttributedTitle(
            attributedString,
            for: .normal
        )
    }
    func setupTextFields() {

        let textFields = [
            self.nameTF,
            self.mobileTF,
            self.dobTF,
            self.addressTF,
            self.genderTF
        ]

        textFields.forEach { field in

            field?.backgroundColor = .clear

            field?.textColor = .white

            field?.tintColor = .white

            field?.delegate = self
        }

        self.mobileTF.keyboardType = .numberPad

//        self.mobileTF.returnKeyType = .done

//        self.addressTF.returnKeyType = .done
        self.nameTF.returnKeyType = .next
        self.mobileTF.returnKeyType = .next
        self.dobTF.returnKeyType = .next
        self.addressTF.returnKeyType = .done
        
        self.genderTF.isUserInteractionEnabled = false
        self.genderTF.inputView = UIView()
    }
    func setupDatePicker() {

        self.datePicker.datePickerMode = .date

        if #available(iOS 13.4, *) {
            self.datePicker.preferredDatePickerStyle = .wheels
        }

        self.dobTF.inputView = self.datePicker

        self.datePicker.addTarget(
            self,
            action: #selector(self.dateChanged),
            for: .valueChanged
        )
    }

    @objc func dateChanged() {

        let formatter = DateFormatter()

        formatter.dateFormat = "dd/MM/yyyy"

        self.dobTF.text =
        formatter.string(
            from: self.datePicker.date
        )
    }
    @IBAction func signupBtnTapped(
        _ sender: UIButton
    ) {

        guard let name = self.nameTF.text,
              !name.isEmpty else {
            AlertManager.showAlert(
                on: self,
                title: "Error",
                message: "Enter Name"
            )
            
            return
        }

        guard let mobile = self.mobileTF.text,
              mobile.count == 10 else {
            AlertManager.showAlert(
                on: self,
                title: "Error",
                message: "Enter Valid Mobile Number"
            )
            return
        }

        print("Signup API")
    }
    @IBAction func loginBtnTapped(
        _ sender: UIButton
    ) {

        self.navigationController?
            .popViewController(
                animated: true
            )
    }
    
    @IBAction func genderDropDownTapped(
        _ sender: UIButton
    ) {

        self.showGenderOptions()
    }
    
    func showGenderOptions() {

        let alert = UIAlertController(
            title: "Select Gender",
            message: nil,
            preferredStyle: .actionSheet
        )

        alert.addAction(
            UIAlertAction(
                title: "Male",
                style: .default
            ) { _ in

                self.genderTF.text = "Male"
            }
        )

        alert.addAction(
            UIAlertAction(
                title: "Female",
                style: .default
            ) { _ in

                self.genderTF.text = "Female"
            }
        )

        alert.addAction(
            UIAlertAction(
                title: "Other",
                style: .default
            ) { _ in

                self.genderTF.text = "Other"
            }
        )

        alert.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .cancel
            )
        )

        self.present(
            alert,
            animated: true
        )
    }
}


// MARK: - UITextField Delegate

extension SignUpViewController: UITextFieldDelegate {

    func textFieldShouldBeginEditing(
        _ textField: UITextField
    ) -> Bool {

        // Gender Dropdown
        if textField == self.genderTF {

            self.showGenderOptions()

            return false
        }

        return true
    }

    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {

        switch textField {

        case self.nameTF:

            self.mobileTF.becomeFirstResponder()

        case self.mobileTF:

            self.dobTF.becomeFirstResponder()

        case self.dobTF:

            self.addressTF.becomeFirstResponder()

        case self.addressTF:

            self.view.endEditing(true)

        default:

            self.view.endEditing(true)
        }

        return true
    }

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {

        // Mobile Number Validation
        if textField == self.mobileTF {

            let allowedCharacters =
            CharacterSet.decimalDigits

            let characterSet =
            CharacterSet(charactersIn: string)

            guard allowedCharacters.isSuperset(
                of: characterSet
            ) else {

                return false
            }

            let currentText =
            textField.text ?? ""

            guard let stringRange =
                Range(range, in: currentText) else {

                return false
            }

            let updatedText =
            currentText.replacingCharacters(
                in: stringRange,
                with: string
            )

            return updatedText.count <= 10
        }

        return true
    }

    func textFieldDidBeginEditing(
        _ textField: UITextField
    ) {

        if textField == self.dobTF {

            if self.dobTF.text?.isEmpty ?? true {

                let formatter = DateFormatter()

                formatter.dateFormat =
                "dd/MM/yyyy"

                self.dobTF.text =
                formatter.string(
                    from: self.datePicker.date
                )
            }
        }
    }

    func textFieldDidEndEditing(
        _ textField: UITextField
    ) {

        textField.resignFirstResponder()
    }
}
