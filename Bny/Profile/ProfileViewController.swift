//
//  ProfileViewController.swift
//  Bny
//
//  Created by Abirami on 01/07/26.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var rateReferContainerView: UIView!
    
    @IBOutlet weak var referralCodeButton: UIButton!
    @IBOutlet weak var copyBtn: UIButton!
    @IBOutlet weak var referralDescLbl: UILabel!
    @IBOutlet weak var referralCodeLbl: UILabel!
    @IBOutlet weak var referralCodeBackView: UIView!
    @IBOutlet weak var referralTitleLbl: UILabel!
    @IBOutlet weak var referralCodeView: UIView!
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var rateIconBackView: UIView!
    @IBOutlet weak var rateImageView: UIImageView!
    @IBOutlet weak var rateTitleLbl: UILabel!
    @IBOutlet weak var rateSubTitleLbl: UILabel!
    @IBOutlet weak var rateBtn: UIButton!
    
    @IBOutlet weak var referView: UIView!
    @IBOutlet weak var referIconBackView: UIView!
    @IBOutlet weak var referImageView: UIImageView!
    @IBOutlet weak var referTitleLbl: UILabel!
    @IBOutlet weak var referSubTitleLbl: UILabel!
    @IBOutlet weak var backContainerView: UIView!
    @IBOutlet weak var referBtn: UIButton!
    
    @IBOutlet weak var profileOptionContainerView: UIView!
    
    @IBOutlet weak var editProfileView: UIView!
    @IBOutlet weak var editProfileIconBackView: UIView!
    @IBOutlet weak var editProfileImageView: UIImageView!
    @IBOutlet weak var editProfileTitleLbl: UILabel!
    @IBOutlet weak var editProfileSubTitleLbl: UILabel!
    @IBOutlet weak var editProfileBtn: UIButton!
    
    @IBOutlet weak var shareAppView: UIView!
    @IBOutlet weak var shareAppIconBackView: UIView!
    @IBOutlet weak var shareAppImageView: UIImageView!
    @IBOutlet weak var shareAppTitleLbl: UILabel!
    @IBOutlet weak var shareAppSubTitleLbl: UILabel!
    @IBOutlet weak var shareAppBtn: UIButton!
    
    @IBOutlet weak var informationTitleLbl: UILabel!
    
    @IBOutlet weak var informationContainerView: UIView!
    
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var aboutIconBackView: UIView!
    @IBOutlet weak var aboutImageView: UIImageView!
    @IBOutlet weak var aboutTitleLbl: UILabel!
    @IBOutlet weak var aboutBtn: UIButton!
    
    @IBOutlet weak var howToUseView: UIView!
    @IBOutlet weak var howToUseIconBackView: UIView!
    @IBOutlet weak var howToUseImageView: UIImageView!
    @IBOutlet weak var howToUseTitleLbl: UILabel!
    @IBOutlet weak var howToUseBtn: UIButton!
    
    @IBOutlet weak var TermsConditionView: UIView!
    @IBOutlet weak var helpSupportIconBackView: UIView!
    @IBOutlet weak var helpSupportImageView: UIImageView!
    @IBOutlet weak var TermsConditionTitleLbl: UILabel!
    @IBOutlet weak var TermsConditionBtn: UIButton!
    
    @IBOutlet weak var logoutContainerView: UIView!
    @IBOutlet weak var logoutIconBackView: UIView!
    @IBOutlet weak var logoutImageView: UIImageView!
    @IBOutlet weak var logoutLbl: UILabel!
    @IBOutlet weak var logoutBtn: UIButton!
    
    private var keyboardHandler: KeyboardHandler!
    private let viewModel = LogoutViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.keyboardHandler = KeyboardHandler(
            viewController: self,
            scrollView: scrollView
        )
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height / 2
        self.profileImageView.layer.borderWidth = 1
        self.profileImageView.layer.borderColor = UIColor.whiteClr.withAlphaComponent(0.13).cgColor//0.08
        self.copyBtn.clipsToBounds = true
        self.copyBtn.layer.masksToBounds = true
        
        [
            self.rateView,
            self.referView,
            self.profileOptionContainerView,
            self.informationContainerView,
            self.logoutContainerView,
            self.referralCodeView
        ].forEach {
            $0?.layer.cornerRadius = ($0 == logoutContainerView) ? 20 : 10//24
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.whiteClr.withAlphaComponent(0.13).cgColor//0.08
        }
        
        [
            self.rateIconBackView,
            self.referIconBackView,
            self.editProfileIconBackView,
            self.shareAppIconBackView,
            self.aboutIconBackView,
            self.howToUseIconBackView,
            self.helpSupportIconBackView,
            self.referralCodeBackView,
            self.logoutIconBackView
        ].forEach {
            $0?.layer.cornerRadius = 12
        }
        //        self.copyBtn.layer.cornerRadius = 0.20
        self.copyBtn.layer.borderWidth = 1
        self.copyBtn.layer.borderColor = UIColor.bnyRed.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.keyboardHandler.registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.keyboardHandler.unregisterKeyboardNotifications()
    }
    
    // MARK: - UI
    
    func setupUI() {
        UIView.setUpBackView(view: self.backContainerView)
        let imageURL = APIConstants.baseURLImage + UserSession.shared.picture
        
        profileImageView.loadImage(
            from: imageURL,
            placeholder: UIImage(named: "Bny_Logo")
        )
        if self.profileImageView.image == nil {
            self.profileImageView.image = UIImage(named: "Bny_Logo")
        } else {
            let imageStr = APIConstants.baseURLImage + UserSession.shared.picture
            self.profileImageView.image = UIImage(named: imageStr)
        }
        self.nameLbl.text = UserSession.shared.name
        self.referralTitleLbl.text = AppStrings.Your_referal_code
        self.referralDescLbl.text = AppStrings.Desc_referal_code
        self.referralCodeLbl.text = UserSession.shared.referralCode
        self.mobileLbl.text = UserSession.shared.countryCode + " " + UserSession.shared.mobile
        self.titleLbl.text = AppStrings.profile
        self.subTitleLbl.text = AppStrings.profile_description
        
        self.informationTitleLbl.text = AppStrings.Profile_Information_Title
        
        self.rateTitleLbl.text = AppStrings.Profile_Rate_Title
        self.rateSubTitleLbl.text = AppStrings.Profile_Rate_SubTitle
        
        self.referTitleLbl.text = AppStrings.Profile_Refer_Title
        self.referSubTitleLbl.text = AppStrings.Profile_Refer_SubTitle
        
        self.editProfileTitleLbl.text = AppStrings.Profile_Edit
        self.editProfileSubTitleLbl.text = AppStrings.Profile_Edit_SubTitle
        
        self.shareAppTitleLbl.text = AppStrings.Profile_Share
        self.shareAppSubTitleLbl.text = AppStrings.Profile_Share_SubTitle
        
        self.aboutTitleLbl.text = AppStrings.Profile_About
        
        self.howToUseTitleLbl.text = AppStrings.Profile_HowToUse
        
        self.TermsConditionTitleLbl.text = AppStrings.Profile_terms
        
        self.logoutLbl.text = AppStrings.Profile_Logout
    }
    
    // MARK: - Actions
    
    @IBAction func backTapped(_ sender: UIButton) {
        self.navigateBack(sender: sender)
    }
    
    @IBAction func rateTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func referTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func editProfileTapped(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func shareAppTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func aboutTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func howToUseTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func TermsConditionTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func referralCodeBtnTapped(_ sender: Any) {
        
    }
    @IBAction func copyBtnAction(_ sender: Any) {
        
    }
    
    func showLogoutPopup() {
        
        let popup = Bundle.main.loadNibNamed("FavouritePopupView", owner: self, options: nil)?.first as! FavouritePopupView
        
        popup.frame = self.view.bounds
        
        popup.configure(title: "Log out", message: "Are you sure you want to logout?", isFromLogout: true)
        
        popup.cancelHandler = { [weak popup] in
            
            popup?.removeFromSuperview()
        }
        
        popup.actionHandler = { [weak self, weak popup] in
            
            guard let self = self else {
                return
            }
            self.logOutService()
            
            
            popup?.removeFromSuperview()
        }
        
        self.view.addSubview(popup)
        
    }
    @IBAction func logoutTapped(_ sender: UIButton) {
        self.showLogoutPopup()
    }
    
    func logOutService() {
        
        self.viewModel.logout { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let response):
                
                AlertManager.showAlert(
                    on: self,
                    title: AppStrings.success,
                    message: response.message ?? ""
                ) {
                    UserSession.shared.isLoggedIn = false
                    UserSession.shared.clear()
                    
                    self.navigationController?.popViewController(animated: true)
                    
                    
                }
                
            case .failure(let error):
                
                AlertManager.showAlert(
                    on: self,
                    title: AppStrings.error,
                    message: error.localizedDescription
                )
            }
        }
    }
}
