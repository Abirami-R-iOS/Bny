//
//  RewardVoucherViewController.swift
//  Bny
//
//  Created by Abirami on 04/08/26.
//

import UIKit

final class RewardVoucherViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var voucherCardView: UIView!
    @IBOutlet weak var rewardMessageView: UIView!
    @IBOutlet weak var voucherDetailsView: UIView!
    @IBOutlet weak var aboutVoucherView: UIView!
    @IBOutlet weak var redeemStepsView: UIView!
    @IBOutlet weak var termsView: UIView!

    @IBOutlet weak var redeemButton: UIButton!

    // Voucher Card

    @IBOutlet weak var voucherAmountLabel: UILabel!
    @IBOutlet weak var storeImageView: UIImageView!
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    // Reward Message

    @IBOutlet weak var rewardTitleLabel: UILabel!
    @IBOutlet weak var rewardTypeLabel: UILabel!

    // Voucher Details
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var dividerView: UIView!
    @IBOutlet weak var topCircleView: UIView!

    @IBOutlet weak var centerCircleView: UIView!

    @IBOutlet weak var bottomCircleView: UIView!
    @IBOutlet weak var voucherTxtLbl: UILabel!
    @IBOutlet weak var voucherIdTitle: UILabel!
    @IBOutlet weak var ApplicableTitle: UILabel!
    @IBOutlet weak var validTillTitle: UILabel!
    @IBOutlet weak var validTillLabel: UILabel!
    @IBOutlet weak var applicableStoreLabel: UILabel!
    @IBOutlet weak var voucherIdLabel: UILabel!

    // About Voucher

    @IBOutlet weak var aboutTitleLabel: UILabel!
    @IBOutlet weak var aboutDescriptionLabel: UILabel!
    @IBOutlet weak var aboutImageView: UIImageView!

    // Terms

    @IBOutlet weak var termTitleLbl: UILabel!
    @IBOutlet weak var term1Label: UILabel!
    @IBOutlet weak var term2Label: UILabel!
    @IBOutlet weak var term3Label: UILabel!
    @IBOutlet weak var term4Label: UILabel!
    @IBOutlet weak var term5Label: UILabel!

    @IBOutlet weak var tagLbl: UILabel!
    @IBOutlet weak var tagLb2: UILabel!
    @IBOutlet weak var tagLb3: UILabel!
    @IBOutlet weak var tagLb4: UILabel!
    @IBOutlet weak var tagLb5: UILabel!
    
    @IBOutlet weak var tagView1: UIView!
    @IBOutlet weak var tagView2: UIView!
    @IBOutlet weak var tagView3: UIView!
    @IBOutlet weak var tagView4: UIView!
    @IBOutlet weak var tagView5: UIView!

    @IBOutlet weak var redeemPointsLbl1: UILabel!
    @IBOutlet weak var redeemPointsLbl2: UILabel!
    @IBOutlet weak var redeemPointsLbl3: UILabel!
    @IBOutlet weak var redeemPointsLbl4: UILabel!
    @IBOutlet weak var redeemPointsLbl5: UILabel!

    
    @IBOutlet weak var howToRedeemLbl: UILabel!
    // MARK: - Properties

//    private let viewModel = RewardVoucherViewModel()

    // MARK: - View Life Cycle

    override func viewDidLoad() {

        super.viewDidLoad()

        initialSetup()

    //    getRewardVoucher()
    }

    // MARK: - Initial Setup

    private func initialSetup() {

        navigationController?.isNavigationBarHidden = true

        configureCards()

        configureCircles()

        configureBadges()

        configureLabels()

        configureRedeemSteps()

        configureTagLabels()

        configureButton()

        loadStaticData()
    }
    // MARK: - UI Setup


    private func configureCards() {

        [
            voucherCardView,
            rewardMessageView,
            voucherDetailsView,
            aboutVoucherView,
            redeemStepsView,
            termsView
        ].forEach {

            $0?.layer.cornerRadius = 10//16
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
            $0?.clipsToBounds = true
        }
    }

    private func configureCircles() {

        [
            topCircleView,
            centerCircleView,
            bottomCircleView
        ].forEach {

            $0?.layoutIfNeeded()
            $0?.layer.cornerRadius = ($0?.frame.height ?? 68) / 2
            $0?.clipsToBounds = true
        }
    }
    
    
    private func configureBadges() {

        [
            tagView1,
            tagView2,
            tagView3,
            tagView4,
            tagView5
        ].forEach {

            $0?.layoutIfNeeded()
            $0?.layer.cornerRadius = ($0?.frame.height ?? 24) / 2
            $0?.clipsToBounds = true
        }
    }
    
    private func configureLabels() {

        [
            term1Label,
            term2Label,
            term3Label,
            term4Label,
            term5Label,
            aboutDescriptionLabel,
            rewardTitleLabel,
            rewardTypeLabel
        ].forEach {

            $0?.numberOfLines = 0
        }

        titleLabel.text = AppStrings.rewardVoucher

        subTitleLbl.text = AppStrings.rewardVoucherSubtitle

        voucherTxtLbl.text = AppStrings.voucherDetails

        aboutTitleLabel.text = AppStrings.aboutVoucher

        howToRedeemLbl.text = AppStrings.howToRedeem

        termTitleLbl.text = AppStrings.termsAndConditions

        validTillTitle.text = AppStrings.validTill

        ApplicableTitle.text = AppStrings.applicableStore

        voucherIdTitle.text = AppStrings.voucherId
    }
    
    private func configureRedeemSteps() {

        redeemPointsLbl1.text = AppStrings.redeemStep1
        redeemPointsLbl2.text = AppStrings.redeemStep2
        redeemPointsLbl3.text = AppStrings.redeemStep3
        redeemPointsLbl4.text = AppStrings.redeemStep4
        redeemPointsLbl5.text = AppStrings.redeemStep5
    }
    
    private func configureTagLabels() {

        tagLbl.text = "1"
        tagLb2.text = "2"
        tagLb3.text = "3"
        tagLb4.text = "4"
        tagLb5.text = "5"
    }
    
    private func configureButton() {

        redeemButton.layer.cornerRadius = 28
        redeemButton.clipsToBounds = true

        redeemButton.setTitle(
            AppStrings.redeemVoucher,
            for: .normal
        )
    }
    

    // MARK: - Static Data

    private func loadStaticData() {

        rewardTitleLabel.text = AppStrings.rewardTitle

        rewardTypeLabel.text = AppStrings.rewardType

        aboutDescriptionLabel.text = AppStrings.aboutVoucherDescription


    }

    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - API

    private func getRewardVoucher() {

//        viewModel.getRewardVoucher { [weak self] result in
//
//            guard let self = self else { return }
//
//            switch result {
//
//            case .success(let response):
//
//                self.configureData(response)
//
//            case .failure(let error):
//
//                print(error.localizedDescription)
//            }
//        }
    }

    // MARK: - Configure Data

//    private func configureData(_ response: RewardVoucherResponseModel) {
//
//        voucherAmountLabel.text = response.data.rewardValue
//
//        storeNameLabel.text = response.data.storeName
//
//        locationLabel.text = response.data.location
//
//        validTillLabel.text = response.data.validTill
//
//        applicableStoreLabel.text = response.data.storeName
//
//        voucherIdLabel.text = response.data.voucherId
//
//        aboutDescriptionLabel.text = response.data.description
//
//        redeemButton.setTitle(
//            "Redeem \(response.data.rewardValue) Voucher",
//            for: .normal
//        )
//    }

    // MARK: - IBActions


    @IBAction private func redeemButtonTapped(_ sender: UIButton) {

//        TODO:
//        Redeem Voucher API
    }
}
