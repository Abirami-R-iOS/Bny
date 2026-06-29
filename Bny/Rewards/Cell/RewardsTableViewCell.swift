//
//  RewardsTableViewCell.swift
//  Bny
//
//  Created by Abirami on 28/06/26.
//

import UIKit

class RewardsTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var leftView: UIView!

    @IBOutlet weak var dividerView: UIView!

    @IBOutlet weak var topCircleView: UIView!

    @IBOutlet weak var centerCircleView: UIView!

    @IBOutlet weak var bottomCircleView: UIView!

    @IBOutlet weak var amountLbl: UILabel!

    @IBOutlet weak var voucherLbl: UILabel!

    @IBOutlet weak var logoImageView: UIImageView!

    @IBOutlet weak var titleLbl: UILabel!

    @IBOutlet weak var locationLbl: UILabel!

    @IBOutlet weak var buttonStackView: UIStackView!

    @IBOutlet weak var giftBtn: UIButton!

    @IBOutlet weak var redeemBtn: UIButton!
    
    @IBOutlet weak var rightView: UIView!

    // MARK: - Variables

        var giftAction:(() -> Void)?
        var redeemAction:(() -> Void)?

        override func awakeFromNib() {
            super.awakeFromNib()
            self.setupUI()
        }

        override func layoutSubviews() {
            super.layoutSubviews()

            self.containerView.layer.cornerRadius = 18
            self.containerView.layer.borderWidth = 1
            self.containerView.layer.borderColor = UIColor.whiteClr.withAlphaComponent(0.08).cgColor
            self.containerView.layer.shadowColor = UIColor.black.cgColor
            self.containerView.layer.shadowOpacity = 0.12
            self.containerView.layer.shadowRadius = 6
            self.containerView.layer.shadowOffset = CGSize(width: 0, height: 2)

            self.leftView.layer.cornerRadius = 18
            self.leftView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]

            self.rightView.layer.cornerRadius = 18
            self.rightView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner]

            self.logoImageView.layer.cornerRadius = self.logoImageView.frame.height / 2

            self.setButtonUI()

            [self.topCircleView,self.centerCircleView,self.bottomCircleView].forEach {
                $0?.layer.cornerRadius = ($0?.frame.height ?? 0) / 2
            }
        }
    func setButtonUI() {
        self.giftBtn.layer.cornerRadius = 12
        self.redeemBtn.layer.cornerRadius = 12

        self.giftBtn.titleLabel?.font = .poppinsSemiBold(size: 12)
        self.redeemBtn.titleLabel?.font = .poppinsSemiBold(size: 12)

        self.giftBtn.titleLabel?.numberOfLines = 2
        self.redeemBtn.titleLabel?.numberOfLines = 2

        self.giftBtn.titleLabel?.textAlignment = .center
        self.redeemBtn.titleLabel?.textAlignment = .center

        
    }

        func setupUI() {

            self.selectionStyle = .none
            self.backgroundColor = .clear
            self.contentView.backgroundColor = .clear

            self.leftView.clipsToBounds = true
            self.rightView.clipsToBounds = true
            self.logoImageView.clipsToBounds = true
            self.dividerView.clipsToBounds = false

//            self.amountLbl.font = .poppinsBold(size: 28)
//            self.voucherLbl.font = .poppinsMedium(size: 16)
//            self.titleLbl.font = .poppinsSemiBold(size: 18)
//            self.locationLbl.font = .poppinsRegular(size: 16)

//            self.giftBtn.titleLabel?.font = .poppinsSemiBold(size: 16)
//            self.redeemBtn.titleLabel?.font = .poppinsSemiBold(size: 16)

//            self.giftBtn.titleLabel?.numberOfLines = 2
//            self.giftBtn.titleLabel?.textAlignment = .center
//            self.redeemBtn.titleLabel?.numberOfLines = 2
//            self.redeemBtn.titleLabel?.textAlignment = .center

//            self.giftBtn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
//            self.redeemBtn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)

            self.voucherLbl.text = AppStrings.Voucher
            self.giftBtn.setTitle(AppStrings.Gift_This_Voucher, for: .normal)
            self.redeemBtn.setTitle(AppStrings.Redeem_Voucher, for: .normal)
        }

        func configure(image:String,title:String,location:String,amount:String,color:UIColor) {

            self.logoImageView.image = UIImage(named: image)
            self.titleLbl.text = title
            self.locationLbl.text = location
            self.amountLbl.text = amount

            self.leftView.backgroundColor = color

            
            self.giftBtn.setTitleColor(color, for: .normal)
            self.giftBtn.layer.borderWidth = 1
//            self.giftBtn.layer.borderColor = UIColor(hex: "A22024").cgColor
            self.giftBtn.layer.borderColor = color.cgColor
            self.redeemBtn.backgroundColor = color
            self.redeemBtn.setTitleColor(.whiteClr, for: .normal)
        }

        @IBAction func giftTapped(_ sender: UIButton) {
            self.giftAction?()
        }

        @IBAction func redeemTapped(_ sender: UIButton) {
            self.redeemAction?()
        }
    }
