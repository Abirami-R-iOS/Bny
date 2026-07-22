//
//  EditProfileViewController.swift
//  Bny
//
//  Created by Abirami on 07/07/26.
//

import UIKit
import CoreLocation

class EditProfileViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var editImageButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var backContainerView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var editButtonContainerView: UIView!
    @IBOutlet weak var nameTitleLbl: UILabel!
    @IBOutlet weak var nameContainerView: UIView!
    @IBOutlet weak var dobTitleLbl: UILabel!
    @IBOutlet weak var dobContainerView: UIView!
    @IBOutlet weak var calendarBtn: UIButton!
    @IBOutlet weak var addressTitleLbl: UILabel!
    @IBOutlet weak var addressContainerView: UIView!
    @IBOutlet weak var genderTitleLbl: UILabel!
    @IBOutlet weak var genderContainerView: UIView!
    @IBOutlet weak var dropDownBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Variables
    
    let imagePicker = UIImagePickerController()
    let genderPicker = UIPickerView()
    let datePicker = UIDatePicker()
    let locationManager = CLLocationManager()
    private var keyboardHandler: KeyboardHandler!
    let viewModel = EditProfileViewModel()
    let genders = ["Male","Female","Others"]
    
    var selectedImage: UIImage?
    private let genderPickerContainer = UIView()
    private let genderOverlayView = UIView()
    
    private let datePickerContainer = UIView()
    private let dateOverlayView = UIView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.configureDelegates()
        self.configurePickers()
        self.configureLocation()
        self.loadProfileData()
        self.keyboardHandler = KeyboardHandler(
                viewController: self,
                scrollView: scrollView
            )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardHandler.registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        keyboardHandler.unregisterKeyboardNotifications()
    }
    
    // MARK: - Setup
    
    func setupUI() {
        UIView.setUpBackView(view: self.backContainerView)
        let imageURL = APIConstants.baseURLImage + UserSession.shared.picture

        self.profileImageView.loadImage(
            from: imageURL,
            placeholder: UIImage(named: "Bny_Logo")
        )
        if self.profileImageView.image == nil {
            self.profileImageView.image = UIImage(named: "Bny_Logo")
        } else {
            let imageStr = APIConstants.baseURLImage + UserSession.shared.picture
            self.profileImageView.image = UIImage(named: imageStr)
        }
        self.nameTitleLbl.text = AppStrings.Edit_Profile_Name
        self.dobTitleLbl.text = AppStrings.Edit_Profile_Date_Of_Birth
        self.genderTitleLbl.text = AppStrings.Edit_Profile_Gender
        self.addressTitleLbl.text = AppStrings.Edit_Profile_Address
        self.profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        self.profileImageView.clipsToBounds = true
        self.profileImageView.layer.borderWidth = 0.75
        self.profileImageView.layer.borderColor = UIColor.silverClr.cgColor
        [self.nameContainerView, self.dobContainerView, self.genderContainerView, self.addressContainerView].forEach{
            $0?.layer.cornerRadius = 12
            $0?.layer.borderWidth = 0.75
            $0?.layer.borderColor = UIColor.silverClr.cgColor
        }
        self.updateButton.setTitle(AppStrings.Edit_Profile_Update_Button, for: .normal)
        self.updateButton.titleLabel?.font = UIFont.poppinsSemiBold(size: 16)
        self.updateButton.layer.cornerRadius = 30
        self.updateButton.backgroundColor = UIColor.bnyRed
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.profileImageTapped))
        self.profileImageView.isUserInteractionEnabled = true
        self.profileImageView.addGestureRecognizer(tap)
        self.editButtonContainerView.layer.cornerRadius = editButtonContainerView.frame.height / 2
        self.editButtonContainerView.clipsToBounds = true
        self.editButtonContainerView.layer.borderWidth = 0.75
        self.editButtonContainerView.layer.borderColor = UIColor.whiteClr.cgColor
        self.editButtonContainerView.backgroundColor = .whiteClr
        
        let dismiss = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        dismiss.cancelsTouchesInView = false
        view.addGestureRecognizer(dismiss)
    }
    
    func configureDelegates() {
        self.imagePicker.delegate = self
        self.nameTextField.delegate = self
        self.dobTextField.delegate = self
        self.genderTextField.delegate = self
        self.addressTextView.delegate = self
    }
    
    // MARK: - Load Data
    
    func loadProfileData() {
        
        // TODO: API Call
        
        self.nameTextField.text = UserSession.shared.name
        self.dobTextField.text = UserSession.shared.dob
        self.addressTextView.text = UserSession.shared.address
        self.genderTextField.text = UserSession.shared.gender
    }
    
    // MARK: - Image
    
    @objc func profileImageTapped() {
        self.profileImageAlert()
    }
    
    
    // MARK: - Validation
    
    func validateFields() -> Bool {
        
        if self.nameTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true {
            self.showAlert("Enter Name")
            return false
        }
        
        if self.dobTextField.text?.isEmpty ?? true {
            self.showAlert("Select DOB")
            return false
        }
        
        if self.addressTextView.text.isEmpty {
            self.showAlert("Enter Address")
            return false
        }
        
        if self.genderTextField.text?.isEmpty ?? true {
            self.showAlert("Select Gender")
            return false
        }
        
        return true
    }
    
    // MARK: - Update
    
    func uploadProfileImage(completion:@escaping(String)->()) {
        
        if self.selectedImage == nil {
            
            completion("")
            return
        }
        
        // TODO:
        // Upload Image API
        
        completion("profile_image_url")
    }

    
    func updateProfile() {
        
        let request = UpdateProfileRequestModel(
            name: nameTextField.text ?? "",
            mobile: UserSession.shared.mobile,
            gender: genderTextField.text ?? "",
            address: addressTextView.text ?? "",
            dob: dobTextField.text ?? "",
            picture: "",
            countryCode: UserSession.shared.countryCode
        )

        viewModel.updateProfile(
            request: request,
            image: selectedImage
        ) { [weak self] result in

            guard let self = self else { return }

            switch result {

            case .success(let response):

                print(response.message ?? "")
                
                if let user = response.data {

                        UserSession.shared.name = user.name ?? ""
                        UserSession.shared.mobile = user.mobile ?? ""
                        UserSession.shared.gender = user.gender ?? ""
                        UserSession.shared.address = user.address ?? ""
                        UserSession.shared.dob = user.dob ?? ""
                        UserSession.shared.picture = user.picture ?? ""
                    }

                AlertManager.showAlert(
                    on: self,
                    title: AppStrings.success,
                    message: response.message ?? "") {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                
                

            case .failure(let error):

                print(error.localizedDescription)
            }
        }
    }    
    
    // MARK: - Helpers
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func showLoader() {
        print("Loader Start")
    }
    
    func hideLoader() {
        print("Loader Stop")
    }
    
    func showAlert(_ message:String) {
        
        let alert = UIAlertController(title: "Alert",
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: AppStrings.OK, style: .default))
        
        self.present(alert, animated: true)
    }
}

// MARK: - Action
extension EditProfileViewController {
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editImageButtonTapped(_ sender: UIButton) {
        self.profileImageAlert()
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
    
    @IBAction func locationButtonTapped(_ sender: UIButton) {
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestLocation()
    }
    
    
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        
        guard validateFields() else { return }
        
        //        self.showLoader()
        
        self.uploadProfileImage { imageURL in
            
            self.updateProfile()
        }
        
    }
}

// MARK: - UITextField
extension EditProfileViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        keyboardHandler.scrollToTextField(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        if textField == dobTextField || textField == genderTextField {
            return false
        }
        
        if textField == self.nameTextField {
            
            let allowed = CharacterSet.letters.union(.whitespaces)
            
            return string.rangeOfCharacter(from: allowed.inverted) == nil
        }
        
        return true
    }
    
}

// MARK: - Picker Configure
extension EditProfileViewController {
    
    // MARK: - Date Picker
    
    
    private func configurePickers() {

        // Date Picker
//        if #available(iOS 13.4, *) {
//            datePicker.preferredDatePickerStyle = .wheels
//        }
//        datePicker.datePickerMode = .date
//        datePicker.maximumDate = Date()
//        datePicker.backgroundColor = UIColor.commonBg
        

//        dobTextField.inputView = datePicker
//        dobTextField.inputAccessoryView = InputAccessoryView(
//            target: self,
//            doneAction: #selector(doneDate),
//            cancelAction: #selector(cancelDate)
//        )

        // Gender Picker
        genderPicker.delegate = self
        genderPicker.dataSource = self
//        genderPicker.backgroundColor = UIColor.commonBg
//        genderTextField.inputView = genderPicker
//        genderTextField.inputAccessoryView = InputAccessoryView(
//            target: self,
//            doneAction: #selector(doneGender),
//            cancelAction: #selector(cancelGender)
//        )
    }
    
//    func configureDatePicker() {
//
//        datePicker.datePickerMode = .date
//        datePicker.maximumDate = Date()
//
//        if #available(iOS 13.4, *) {
//            datePicker.preferredDatePickerStyle = .inline
//        }
//
//        dobTextField.inputView = datePicker
//        dobTextField.inputAccessoryView = dateToolbar
//    }
    @objc
    func doneDate() {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        dobTextField.text = formatter.string(from: datePicker.date)

        self.hideDatePicker()
    }
//    @objc func doneDate() {
//        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        
//        self.dobTextField.text = formatter.string(from: self.datePicker.date)
//        
//        dobTextField.resignFirstResponder()
////        view.endEditing(true)
//    }
    
    @objc func cancelDate() {
//        view.endEditing(true)
//        self.dobTextField.resignFirstResponder()
        self.hideDatePicker()
    }
    
    // MARK: - Gender Picker
    
    
//    func configureGenderPicker() {
//        
//        self.genderPicker.delegate = self
//        self.genderPicker.dataSource = self
//        
//        self.genderTextField.inputView = genderPicker
//        self.genderTextField.inputAccessoryView = genderToolbar
//    }
    
    @objc func cancelGender() {
//        self.genderTextField.resignFirstResponder()
        hideGenderPicker()
    }
    @objc
    func doneGender() {

        let row = genderPicker.selectedRow(inComponent: 0)

        genderTextField.text = genders[row]

        hideGenderPicker()
    }
//    @objc func doneGender() {
//        
//        let selectedRow = genderPicker.selectedRow(inComponent: 0)
//        
//        if selectedRow >= 0 {
//            genderTextField.text = genders[selectedRow]
//        }
////        
//     self.genderTextField.resignFirstResponder()
//    }
    
    // MARK: - Image Picker
    
    func profileImageAlert() {
        let sheet = UIAlertController(title: "Select Image", message: nil, preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "Camera", style: .default){ _ in
            self.openCamera()
        })
        
        sheet.addAction(UIAlertAction(title: "Gallery", style: .default){ _ in
            self.openGallery()
        })
        
        sheet.addAction(UIAlertAction(title: AppStrings.cancel, style: .cancel))
        
        present(sheet, animated: true)
    }
    
    func openCamera() {
        
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        
        self.imagePicker.sourceType = .camera
        present(self.imagePicker, animated: true)
    }
    
    func openGallery() {
        
        self.imagePicker.sourceType = .photoLibrary
        present(self.imagePicker, animated: true)
    }
    
}

extension EditProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
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
        self.genderTextField.text = self.genders[row]
//        self.genderTextField.resignFirstResponder()
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            self.profileImageView.image = image
            self.selectedImage = image
        } else {
            self.profileImageView.image = UIImage(named: "Bny_Logo")
        }
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}

// MARK: - Location
extension EditProfileViewController: CLLocationManagerDelegate {
    
    
    func configureLocation() {
        self.locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else { return }
        
        CLGeocoder().reverseGeocodeLocation(location) { places, error in
            
            guard error == nil else { return }
            
            if let place = places?.first {
                
                self.addressTextView.text = [
                    place.name,
                    place.locality,
                    place.administrativeArea,
                    place.country
                ].compactMap{$0}.joined(separator: ", ")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        
        print(error.localizedDescription)
    }
}

extension EditProfileViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        keyboardHandler.scrollToTextView(textView)
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        // Nothing needed
    }
    
}

extension EditProfileViewController {
    
//    func createToolbar(doneAction: Selector, cancelAction: Selector) -> UIToolbar {
//
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//
//        let cancelButton = UIBarButtonItem(
//            title: AppStrings.cancel,
//            style: .plain,
//            target: self,
//            action: cancelAction
//        )
//        cancelButton.tintColor = .silverClr
//
//        let flexibleSpace = UIBarButtonItem.flexibleSpace()
//
//        let doneButton = UIBarButtonItem(
//            title: AppStrings.done,
//            style: .plain,
//            target: self,
//            action: doneAction
//        )
//        doneButton.tintColor = .bnyRed
//
//        toolbar.items = [
//            cancelButton,
//            flexibleSpace,
//            doneButton
//        ]
//
//        return toolbar
//    }
}
