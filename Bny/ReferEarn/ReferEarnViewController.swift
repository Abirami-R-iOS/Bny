//
//  ReferEarnViewController.swift
//  Bny
//
//  Created by Abirami on 05/08/26.
//

import UIKit

final class ReferEarnViewController:UIViewController{

    @IBOutlet weak var backBtn:UIButton!
    @IBOutlet weak var titleLbl:UILabel!
    @IBOutlet weak var subTitleLbl:UILabel!
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var cardContainerView:UIView!

    @IBOutlet weak var referFrndBtnView: UIView!
    @IBOutlet weak var copyBtn: UIButton!
    //    @IBOutlet weak var backButton:UIButton!
//    @IBOutlet weak var titleLabel:UILabel!
//    @IBOutlet weak var subtitleLabel:UILabel!

    @IBOutlet weak var referralCardView:UIView!
    @IBOutlet weak var referralCodeTitleLabel:UILabel!
    @IBOutlet weak var referralCodeLabel:UILabel!
    @IBOutlet weak var referralDescriptionLabel:UILabel!
    @IBOutlet weak var whatsappButton:UIButton!
    @IBOutlet weak var shareButton:UIButton!
    @IBOutlet weak var giftImageView:UIImageView!

    @IBOutlet weak var summaryCardView:UIView!
    @IBOutlet weak var totalReferralCardView:UIView!
    @IBOutlet weak var redeemedReferralCardView:UIView!

    @IBOutlet weak var redeemedReferralLbl: UILabel!
    @IBOutlet weak var redeemedReferralValue: UILabel!
    @IBOutlet weak var totalReferralLbl: UILabel!
    @IBOutlet weak var totalReferralValue: UILabel!
    @IBOutlet weak var milestoneRewardView:UIView!
    @IBOutlet weak var rewardCardOneView:UIView!
    @IBOutlet weak var rewardCardTwoView:UIView!
    @IBOutlet weak var rewardCardThreeView:UIView!

    @IBOutlet weak var amountLbl1: UILabel!
    
    @IBOutlet weak var referralTitle1: UILabel!
    @IBOutlet weak var rewardsValue1: UILabel!
    
    @IBOutlet weak var amountLbl2: UILabel!
    
    @IBOutlet weak var referralTitle2: UILabel!
    @IBOutlet weak var rewardsValue2: UILabel!
    
    @IBOutlet weak var amountLbl3: UILabel!
    
    @IBOutlet weak var referralTitle3: UILabel!
    @IBOutlet weak var rewardsValue3: UILabel!
    
    
    @IBOutlet weak var howItWorksCardView:UIView!
    @IBOutlet weak var stepOneImageView:UIImageView!
    @IBOutlet weak var stepOneLabel:UILabel!
    
    @IBOutlet weak var stepTwoImageView:UIImageView!
    @IBOutlet weak var stepTwoLabel:UILabel!
    
    @IBOutlet weak var stepThreeImageView:UIImageView!
    @IBOutlet weak var stepThreeLabel:UILabel!
    
    @IBOutlet weak var stepFourImageView:UIImageView!
    @IBOutlet weak var stepFourLabel:UILabel!
    
    @IBOutlet weak var referFrndBtnLbl: UILabel!
    @IBOutlet weak var referFriendBtn: UIButton!
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.initialSetup()
        self.loadStaticData()
    }

    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        self.referFrndBtnView.layer.cornerRadius = 10//self.referFrndBtnView.frame.height/2
        self.referFrndBtnView.clipsToBounds = true
        self.referralCardView.applyRewardBannerGradient()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
       
    }
    private func initialSetup(){
        
        self.navigationController?.isNavigationBarHidden=true
        [self.whatsappButton,self.shareButton].forEach({
            $0?.layer.cornerRadius = 5
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.withAlphaComponent(0.08).cgColor
            $0?.clipsToBounds = true
        })
        [self.referralCardView,self.totalReferralCardView, self.redeemedReferralCardView, self.rewardCardOneView, self.rewardCardTwoView, self.rewardCardThreeView,self.cardContainerView].forEach{
            $0?.layer.cornerRadius = 15
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor=UIColor.white.withAlphaComponent(0.08).cgColor
            $0?.clipsToBounds = true
        }
       
        self.titleLbl.text=AppStrings.referAndEarn
        self.subTitleLbl.text=AppStrings.referAndEarnSubTitle
        self.referFrndBtnLbl.text = AppStrings.inviteFriendsNow
    }

    private func loadStaticData(){}

    @IBAction func whatsappBtnActn(_ sender: Any) {
    }
    @IBAction func shareBtnActn(_ sender: Any) {
    }
    @IBAction private func backButtonTapped(_ sender:UIButton){
        self.navigationController?.popViewController(animated:true)
    }

    @IBAction func copyBtnAction(_ sender: Any) {
    }
    @IBAction private func redeemButtonTapped(_ sender:UIButton){}
}
