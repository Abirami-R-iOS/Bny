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
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var rateReferContainerView: UIView!
    
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
    
    @IBOutlet weak var helpSupportView: UIView!
    @IBOutlet weak var helpSupportIconBackView: UIView!
    @IBOutlet weak var helpSupportImageView: UIImageView!
    @IBOutlet weak var helpSupportTitleLbl: UILabel!
    @IBOutlet weak var helpSupportBtn: UIButton!
    
    @IBOutlet weak var logoutContainerView: UIView!
    @IBOutlet weak var logoutIconBackView: UIView!
    @IBOutlet weak var logoutImageView: UIImageView!
    @IBOutlet weak var logoutLbl: UILabel!
    @IBOutlet weak var logoutBtn: UIButton!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height / 2
        self.profileImageView.layer.borderWidth = 1
        self.profileImageView.layer.borderColor = UIColor.whiteClr.withAlphaComponent(0.08).cgColor
        
        [
            self.rateView,
            self.referView,
            self.profileOptionContainerView,
            self.informationContainerView,
            self.logoutContainerView
        ].forEach {
            $0?.layer.cornerRadius = 24
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.whiteClr.withAlphaComponent(0.08).cgColor
        }
        
        [
            self.rateIconBackView,
            self.referIconBackView,
            self.editProfileIconBackView,
            self.shareAppIconBackView,
            self.aboutIconBackView,
            self.howToUseIconBackView,
            self.helpSupportIconBackView,
            self.logoutIconBackView
        ].forEach {
            $0?.layer.cornerRadius = 12
        }
    }
    
    // MARK: - UI
    
    func setupUI() {
        UIView.setUpBackView(view: self.backContainerView)
        self.nameLbl.text = "Abirami"
        
        self.mobileLbl.text = "+91 9876543210"
        
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
        
        self.helpSupportTitleLbl.text = AppStrings.Profile_HelpSupport
        
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
    
    @IBAction func helpSupportTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func logoutTapped(_ sender: UIButton) {
        
    }
}
