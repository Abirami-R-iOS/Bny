//
//  SignupViewController.swift
//  Bny
//
//  Created by Abirami on 25/05/26.
//

import UIKit
import CountryPickerView

class SignUpViewController: UIViewController {

    // MARK: - OUTLETS

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var overlayView: UIView!

    @IBOutlet weak var logoImageView: UIImageView!

    @IBOutlet weak var nameTF: UITextField!

    @IBOutlet weak var mobileTF: UITextField!

    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var referCodeTF: UITextField!

    @IBOutlet weak var genderTF: UITextField!

    @IBOutlet weak var genderDropDownBtn: UIButton!

    @IBOutlet weak var signupBtn: UIButton!

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var referCodeContainerView: UIView!
    @IBOutlet weak var nameContainerView: UIView!

    @IBOutlet weak var mobileContainerView: UIView!

    @IBOutlet weak var dobContainerView: UIView!


    @IBOutlet weak var genderContainerView: UIView!
    @IBOutlet weak var countryBtn: UIButton!

    // MARK: - VARIABLES
    let countryPickerView = CountryPickerView()
    let datePicker = UIDatePicker()
    let viewModel = SignUpViewModel()

    let genderList = [
        "Male",
        "Female",
        "Other"
    ]
    
    let genderPicker = UIPickerView()
    let genders = ["Male","Female","Others"]
    
    private let genderPickerContainer = UIView()
    private let genderOverlayView = UIView()
    
    private let datePickerContainer = UIView()
    private let dateOverlayView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        self.setupUI()
        self.setupTextFields()
        self.setupDatePicker()
    }
    func setupUI() {
        
        self.countryPickerView.delegate = self

        let country = countryPickerView.selectedCountry
        let flagImage = country.flag.withRenderingMode(.alwaysOriginal)
        self.countryBtn.setImage(flagImage, for: .normal)
        self.countryBtn.tintColor = .whiteClr
        self.countryBtn.setTitle(
            " \(country.phoneCode)",
            for: .normal
        )

        let containerViews = [
            self.nameContainerView,
            self.mobileContainerView,
            self.dobContainerView,
            self.genderContainerView,
            self.referCodeContainerView
        ]
        
        containerViews.forEach { view in

            view?.applyGlassBackground()
//            view?.layer.cornerRadius = 13

            view?.layer.borderWidth = 1

            view?.layer.borderColor =
            UIColor.white.withAlphaComponent(0.2).cgColor

//            view?.backgroundColor = .clear
        }
        self.signupBtn.layer.cornerRadius = 20
        self.signupBtn.clipsToBounds = true
        self.signupBtn.backgroundColor = .bnyRed

        let attributedString = NSAttributedString(
            string: AppStrings.signIn,
            attributes: [
                .underlineStyle:
                    NSUnderlineStyle.single.rawValue,
                .foregroundColor:
                    UIColor.bnyRed
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
            self.genderTF,
            self.referCodeTF
        ]

        textFields.forEach { field in
            if field == self.mobileTF {
                field?.attributedPlaceholder = NSAttributedString(
                    string: AppStrings.enter_phone_number,
                    attributes: [
                        .foregroundColor:
                            UIColor.whiteClr.withAlphaComponent(0.7),
                        .font: UIFont.poppinsMedium(size: 15)
                    ]
                )
            } else if field == self.dobTF {
                field?.attributedPlaceholder = NSAttributedString(
                    string: AppStrings.Edit_Profile_DOB_Placeholder,
                    attributes: [
                        .foregroundColor:
                            UIColor.whiteClr.withAlphaComponent(0.7),
                        .font: UIFont.poppinsMedium(size: 15)
                    ]
                )
            } else if field == self.genderTF {
                field?.attributedPlaceholder = NSAttributedString(
                    string: AppStrings.Edit_Profile_Gender_Placeholder,
                    attributes: [
                        .foregroundColor:
                            UIColor.whiteClr.withAlphaComponent(0.7),
                        .font: UIFont.poppinsMedium(size: 15)
                    ]
                )
            } else if field == self.referCodeTF {
                field?.attributedPlaceholder = NSAttributedString(
                    string: AppStrings.Enter_Referal_Code,
                    attributes: [
                        .foregroundColor:
                            UIColor.whiteClr.withAlphaComponent(0.7),
                        .font: UIFont.poppinsMedium(size: 15)
                    ]
                )
            } else if field == self.nameTF {
                field?.attributedPlaceholder = NSAttributedString(
                    string: AppStrings.enter_name,
                    attributes: [
                        .foregroundColor:
                            UIColor.whiteClr.withAlphaComponent(0.7),
                        .font: UIFont.poppinsMedium(size: 15)
                    ]
                )
            }
            field?.tintColor = .whiteClr

            field?.delegate = self
            field?.textColor = UIColor.whiteClr
        }

        self.mobileTF.keyboardType = .phonePad

        self.mobileTF.returnKeyType = .done

        self.nameTF.returnKeyType = .next
        
        self.mobileTF.keyboardType = .numbersAndPunctuation
        mobileTF.enablesReturnKeyAutomatically = true
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )

        view.addGestureRecognizer(tapGesture)
//        self.phoneTextField.addDoneButton(
//            target: self,
//            action: #selector(doneButtonTapped)
//        )
    
    
        
//        self.mobileTF.returnKeyType = .next
        self.dobTF.returnKeyType = .next
        self.referCodeTF.returnKeyType = .done
        
        self.genderTF.isUserInteractionEnabled = false
        self.genderTF.inputView = UIView()
        self.dobTF.isUserInteractionEnabled = false
        self.dobTF.inputView = UIView()
    }
    
    @objc func dismissKeyboard() {

        view.endEditing(true)
    }
    
    func setupDatePicker() {

        self.datePicker.datePickerMode = .date

        if #available(iOS 13.4, *) {
            self.datePicker.preferredDatePickerStyle = .wheels
        }
//        self.dobTF.tintColor = .clear
//        self.dobTF.inputView = self.datePicker

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
    
    @IBAction func countryBtnTapped(_ sender: UIButton) {

        self.countryPickerView.showCountriesList(
            from: self
        )
    }
    
    @IBAction func signupBtnTapped(_ sender: UIButton) {

        guard let name = self.nameTF.text?
            .trimmingCharacters(in: .whitespacesAndNewlines),
              !name.isEmpty else {

            AlertManager.showAlert(
                on: self,
                title: "Error",
                message: "Please enter your name."
            )
            return
        }

        let nameRegex = "^[A-Za-z ]+$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)

        guard namePredicate.evaluate(with: name) else {

            AlertManager.showAlert(
                on: self,
                title: "Error",
                message: "Please enter a valid name."
            )
            return
        }

        guard let phone = self.mobileTF.text?
            .trimmingCharacters(in: .whitespacesAndNewlines),
              !phone.isEmpty else {

            AlertManager.showAlert(
                on: self,
                title: "Error",
                message: "Please enter your mobile number."
            )
            return
        }

        let phoneRegex = "^[0-9]{10}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)

        guard phonePredicate.evaluate(with: phone) else {

            AlertManager.showAlert(
                on: self,
                title: "Error",
                message: "Please enter a valid 10-digit mobile number."
            )
            return
        }

        guard let dob = self.dobTF.text?
            .trimmingCharacters(in: .whitespacesAndNewlines),
              !dob.isEmpty else {

            AlertManager.showAlert(
                on: self,
                title: "Error",
                message: "Please select your date of birth."
            )
            return
        }

        guard let gender = self.genderTF.text?
            .trimmingCharacters(in: .whitespacesAndNewlines),
              !gender.isEmpty else {

            AlertManager.showAlert(
                on: self,
                title: "Error",
                message: "Please select your gender."
            )
            return
        }
        self.viewModel.signUp(mobile: self.mobileTF.text ?? "", countryCode: "+91")

        
    }
    
    @IBAction func calendarButtonTapped(_ sender: UIButton) {
//        dobTextField.inputView = datePicker
//        dobTextField.becomeFirstResponder()
        showDatePicker()
    }
    
    @IBAction func genderDropDownTapped(_ sender: UIButton) {
//        self.genderTextField.inputView = genderPicker

        
//        self.genderTextField.becomeFirstResponder()
        showGenderPicker()
    }
    
    @IBAction func loginBtnTapped(
        _ sender: UIButton
    ) {

        self.navigationController?
            .popViewController(
                animated: true
            )
    }
}


extension SignUpViewController: SignUpViewModelDelegate {
    
    func didReceiveSignUpOTP() {
        
        print("OTP",self.viewModel.otp ?? 0)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
        vc.name = self.nameTF.text ?? ""
        vc.dob = self.dobTF.text ?? ""
        vc.gender = self.genderTF.text ?? ""
        vc.referralCode = self.referCodeTF.text ?? ""
        vc.responseOTP = "\(self.viewModel.otp ?? 0)"
        vc.countryCode = self.countryBtn.titleLabel?.text ?? ""
        vc.mobileNumber = self.mobileTF.text ?? ""
        vc.cameFrom = "signup"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didReceiveSignUpError(_ message: String) {
        AlertManager.showAlert(on: self, message: message)
        print(message)
    }
}

extension SignUpViewController {
    @objc func hideDatePicker() {

        UIView.animate(withDuration: 0.25, animations: {

            self.datePickerContainer.frame.origin.y =
                self.view.frame.height

            self.dateOverlayView.alpha = 0

        }) { _ in

            self.datePickerContainer.removeFromSuperview()
            self.dateOverlayView.removeFromSuperview()
        }
    }
    
    func showDatePicker() {

        // Remove previous subviews
        datePickerContainer.subviews.forEach { $0.removeFromSuperview() }

        dateOverlayView.frame = view.bounds
        dateOverlayView.backgroundColor = UIColor.black.withAlphaComponent(0.45)

        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(hideDatePicker))
        dateOverlayView.addGestureRecognizer(tap)

        view.addSubview(dateOverlayView)

        datePickerContainer.frame = CGRect(
            x: 0,
            y: view.frame.height,
            width: view.frame.width,
            height: 340
        )

        datePickerContainer.backgroundColor = .cardBg
        datePickerContainer.layer.cornerRadius = 24
        datePickerContainer.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]

        let accessory = InputAccessoryView(
            target: self,
            doneAction: #selector(doneDate),
            cancelAction: #selector(cancelDate)
        )

        accessory.translatesAutoresizingMaskIntoConstraints = false

        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }

        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.backgroundColor = .cardBg
        datePicker.setValue(UIColor.whiteClr, forKey: "textColor")
        datePicker.setValue(false, forKey: "highlightsToday")
        datePicker.tintColor = .whiteClr
        datePicker.translatesAutoresizingMaskIntoConstraints = false

        datePickerContainer.addSubview(accessory)
        datePickerContainer.addSubview(datePicker)

        view.addSubview(datePickerContainer)

        NSLayoutConstraint.activate([

            accessory.topAnchor.constraint(equalTo: datePickerContainer.topAnchor),
            accessory.leadingAnchor.constraint(equalTo: datePickerContainer.leadingAnchor),
            accessory.trailingAnchor.constraint(equalTo: datePickerContainer.trailingAnchor),
            accessory.heightAnchor.constraint(equalToConstant: 60),

//            datePicker.centerXAnchor.constraint(equalTo: datePickerContainer.centerXAnchor),
            datePicker.topAnchor.constraint(equalTo: accessory.bottomAnchor),
            datePicker.leadingAnchor.constraint(equalTo: datePickerContainer.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: datePickerContainer.trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: datePickerContainer.bottomAnchor)
        ])

        UIView.animate(withDuration: 0.3) {

            self.datePickerContainer.frame.origin.y =
            self.view.frame.height - 340
        }
    }
    
    func showGenderPicker() {

        genderOverlayView.frame = view.bounds
        genderOverlayView.backgroundColor = UIColor.black.withAlphaComponent(0.45)

        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(hideGenderPicker))
        genderOverlayView.addGestureRecognizer(tap)

        view.addSubview(genderOverlayView)

        genderPickerContainer.frame = CGRect(
            x: 0,
            y: view.frame.height,
            width: view.frame.width,
            height: 340
        )

        genderPickerContainer.backgroundColor = .cardBg
        genderPickerContainer.layer.cornerRadius = 24
        genderPickerContainer.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]

        let accessory = InputAccessoryView(
            target: self,
            doneAction: #selector(doneGender),
            cancelAction: #selector(cancelGender)
        )

        accessory.frame = CGRect(
            x: 0,
            y: 0,
            width: genderPickerContainer.frame.width,
            height: 60
        )

        genderPicker.frame = CGRect(
            x: 0,
            y: 60,
            width: genderPickerContainer.frame.width,
            height: 280
        )

        genderPicker.delegate = self
        genderPicker.dataSource = self
        genderPicker.backgroundColor = .cardBg
        genderPicker.tintColor = .whiteClr
        genderPickerContainer.addSubview(accessory)
        genderPickerContainer.addSubview(genderPicker)

        view.addSubview(genderPickerContainer)

        UIView.animate(withDuration: 0.3) {

            self.genderPickerContainer.frame.origin.y =
                self.view.frame.height - 340
        }
    }
    
    @objc
    func hideGenderPicker() {

        UIView.animate(withDuration: 0.25, animations: {

            self.genderPickerContainer.frame.origin.y =
                self.view.frame.height

            self.genderOverlayView.alpha = 0

        }) { _ in

            self.genderPickerContainer.removeFromSuperview()
            self.genderOverlayView.removeFromSuperview()
        }
    }
}


extension SignUpViewController: UIPickerViewDelegate, UIPickerViewDataSource  {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.genders.count
    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        self.genders[row]
//    }
    
    func pickerView(_ pickerView: UIPickerView,
                    attributedTitleForRow row: Int,
                    forComponent component: Int) -> NSAttributedString? {

        return NSAttributedString(
            string: genders[row],
            attributes: [
                .foregroundColor: UIColor.whiteClr,
                .font: UIFont.poppinsMedium(size: 17)
            ]
        )
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.genderTF.text = self.genders[row]
    }
}


extension SignUpViewController: CountryPickerViewDelegate {

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



extension SignUpViewController {
    
    // MARK: - Date Picker
    
    
    private func configurePickers() {
        // Gender Picker
        genderPicker.delegate = self
        genderPicker.dataSource = self
    }

    @objc
    func doneDate() {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        dobTF.text = formatter.string(from: datePicker.date)

        self.hideDatePicker()
    }
    
    @objc func cancelDate() {
        self.hideDatePicker()
    }
    
    // MARK: - Gender Picker
    
    @objc func cancelGender() {
        hideGenderPicker()
    }
    @objc
    func doneGender() {
        let row = genderPicker.selectedRow(inComponent: 0)
        genderTF.text = genders[row]
        hideGenderPicker()
    }
    
}


// MARK: - UITextField Delegate

extension SignUpViewController: UITextFieldDelegate {

//    func textFieldShouldBeginEditing(
//        _ textField: UITextField
//    ) -> Bool {
//
//        // Gender Dropdown
//        if textField == self.genderTF {
//
//            self.showGenderOptions()
//
//            return false
//        }
//
//        return true
//    }

    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {

        switch textField {

        case self.nameTF:

            self.mobileTF.becomeFirstResponder()

        case self.mobileTF:
            textField.resignFirstResponder()

        case self.dobTF:

            self.referCodeTF.becomeFirstResponder()

        case self.referCodeTF:

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

        
        if textField == dobTF || textField == genderTF {
            return false
        }
        
        if textField == self.nameTF {
            
            let allowed = CharacterSet.letters.union(.whitespaces)
            
            return string.rangeOfCharacter(from: allowed.inverted) == nil
        }
        
        
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

//        if textField == self.dobTF {
//
//            if self.dobTF.text?.isEmpty ?? true {
//
//                let formatter = DateFormatter()
//
//                formatter.dateFormat =
//                "dd/MM/yyyy"
//
////                self.dobTF.text =
////                formatter.string(
////                    from: self.datePicker.date
////                )
//            }
//        }
    }

    func textFieldDidEndEditing(
        _ textField: UITextField
    ) {

        textField.resignFirstResponder()
    }
}
