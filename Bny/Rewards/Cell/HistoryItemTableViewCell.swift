//
//  HistoryItemTableViewCell.swift
//  Bny
//
//  Created by Abirami on 29/06/26.
//

import UIKit

class HistoryItemTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    
    @IBOutlet weak var topCircleView: UIView!
    @IBOutlet weak var centerCircleView: UIView!
    @IBOutlet weak var bottomCircleView: UIView!
    
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var voucherLbl: UILabel!
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    
    @IBOutlet weak var locationImage: UIImageView!
    
    @IBOutlet weak var redeemedCodeImage: UIImageView!
    @IBOutlet weak var redeemedCodeLabel: UILabel!
    @IBOutlet weak var redeemedCodeValueLabel: UILabel!
    
    @IBOutlet weak var giftedOnImage: UIImageView!
    @IBOutlet weak var giftedOnLabel: UILabel!
    
    @IBOutlet weak var giftedLabelView: UIView!
    @IBOutlet weak var giftedLabel: UILabel!
    @IBOutlet weak var giftedOnValueLabel: UILabel!
    @IBOutlet weak var giftedLAbelImage: UIImageView!
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
        setupFonts()
        setupGiftedLabel()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        logoImageView.image = UIImage(named: "Placeholder")
        
        amountLbl.text = nil
        titleLbl.text = nil
        locationLbl.text = nil
        
        redeemedCodeLabel.text = nil
        redeemedCodeValueLabel.text = nil
        giftedOnLabel.text = nil
        
        giftedLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupCorners()
        
        logoImageView.layer.cornerRadius =
        logoImageView.frame.height / 2
        
        [
            topCircleView,
            centerCircleView,
            bottomCircleView
        ].forEach {
            $0?.layer.cornerRadius =
            ($0?.frame.height ?? 0) / 2
        }
    }
}

// MARK: - UI Setup

private extension HistoryItemTableViewCell {
    
    func setupUI() {
        
        selectionStyle = .none
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        leftView.clipsToBounds = true
        rightView.clipsToBounds = true
        logoImageView.clipsToBounds = true
        
        voucherLbl.text = AppStrings.Voucher
        
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor =
        UIColor.whiteClr.withAlphaComponent(0.08).cgColor
        
        containerView.layer.shadowColor =
        UIColor.black.cgColor
        
        containerView.layer.shadowOpacity = 0.12
        containerView.layer.shadowRadius = 6
        containerView.layer.shadowOffset =
        CGSize(width: 0, height: 2)
    }
    
    func setupCorners() {
        
        containerView.layer.cornerRadius = 18
        
        leftView.layer.cornerRadius = 18
        leftView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMinXMaxYCorner
        ]
        
        rightView.layer.cornerRadius = 18
        rightView.layer.maskedCorners = [
            .layerMaxXMinYCorner,
            .layerMaxXMaxYCorner
        ]
    }
    
    func setupFonts() {
        
        amountLbl.font =
            .poppinsBold(size: 21)
        
        voucherLbl.font =
            .poppinsMedium(size: 11)
        
        titleLbl.font =
            .poppinsSemiBold(size: 14)
        
        locationLbl.font =
            .poppinsRegular(size: 12)
        
        redeemedCodeLabel.font =
            .poppinsRegular(size: 12)
        
        redeemedCodeValueLabel.font =
            .poppinsSemiBold(size: 12)
        
        giftedOnLabel.font =
            .poppinsRegular(size: 12)
        
        giftedLabel.font =
            .poppinsSemiBold(size: 12)
    }
    
    func setupGiftedLabel() {
        
        giftedLabelView.layer.cornerRadius = 8
        giftedLabel.clipsToBounds = true
        
//        giftedLabel.textAlignment = .center
    }
}

// MARK: - Configure

extension HistoryItemTableViewCell {
    
    func configure(image: String, title: String, location: String, amount: String, color: String, redeemedCode: String, giftedOn: String, status: HistoryStatus?, claimedId: Int?, userId: String?) {
        
        // MARK: Basic Data
        
        amountLbl.text = amount
        titleLbl.text = title
        locationLbl.text = location
        
        redeemedCodeLabel.text = AppStrings.redeemedCodeOn
        
        redeemedCodeValueLabel.text = redeemedCode
        
        giftedOnLabel.text = AppStrings.giftedOn
        
        // MARK: Image
        
        logoImageView.image =
        UIImage(named: "Placeholder")
        
        ImageDownloader.shared.loadImage(from: image, into: logoImageView)
        
        // MARK: Color
        
        let rewardColor = UIColor(hex: color)
        
        leftView.backgroundColor = rewardColor
        
        redeemedCodeValueLabel.textColor = rewardColor
        giftedOnValueLabel.textColor = rewardColor
        giftedLabel.textColor = rewardColor
        
        giftedLabelView.backgroundColor = rewardColor.withAlphaComponent(0.18)
        
        // MARK: Icons
        
        locationImage.tintColor = UIColor.blackClr
        
        redeemedCodeImage.tintColor = rewardColor
        
        giftedOnImage.tintColor = rewardColor
        
        giftedLAbelImage.tintColor = rewardColor
        
        
        self.updateStatus(
            status: status,
            claimedId: claimedId,
            userId: Int(userId ?? "")
        )
    }
    
    
    func updateStatus(status: HistoryStatus?, claimedId: Int?, userId: Int?) {
        
        switch status {
            
        case .claimed:
            
            self.giftedLabel.text = AppStrings.gifted
            self.giftedOnLabel.text = AppStrings.giftedOn
            
        case .redeemed:
            
            if let claimedId,
               claimedId != 0,
               claimedId != userId {
                
                self.giftedLabel.text = AppStrings.gifted
                self.giftedOnLabel.text = AppStrings.giftedOn
                
            } else {
                
                self.giftedLabel.text = AppStrings.redeemed
                self.giftedOnLabel.text = AppStrings.redeemedOn
            }
            
        default:
            
            self.giftedLabel.text = "Progress"
            self.giftedOnLabel.text = nil
        }
    }
}

enum HistoryStatus: String {
    case claimed
    case redeemed
}
