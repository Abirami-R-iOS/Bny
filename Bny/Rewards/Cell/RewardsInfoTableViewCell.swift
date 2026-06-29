//
//  RewardsInfoTableViewCell.swift
//  Bny
//
//  Created by Abirami on 29/06/26.
//

import UIKit

class RewardsInfoTableViewCell: UITableViewCell {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var cardContainerView: UIView!
    
    @IBOutlet weak var earnPointsView: UIView!
    @IBOutlet weak var earnPointsImageView: UIImageView!
    @IBOutlet weak var earnPointsTitleLbl: UILabel!
    @IBOutlet weak var earnPointsSubTitleLbl: UILabel!
    
    @IBOutlet weak var voucherView: UIView!
    @IBOutlet weak var voucherImageView: UIImageView!
    @IBOutlet weak var voucherTitleLbl: UILabel!
    @IBOutlet weak var voucherSubTitleLbl: UILabel!
    
    @IBOutlet weak var redeemView: UIView!
    @IBOutlet weak var redeemImageView: UIImageView!
    @IBOutlet weak var redeemTitleLbl: UILabel!
    @IBOutlet weak var redeemSubTitleLbl: UILabel!
    
    @IBOutlet weak var enjoyView: UIView!
    @IBOutlet weak var enjoyImageView: UIImageView!
    @IBOutlet weak var enjoyTitleLbl: UILabel!
    @IBOutlet weak var enjoySubTitleLbl: UILabel!
    
    @IBOutlet weak var dividerView1: UIView!
    @IBOutlet weak var dividerView2: UIView!
    @IBOutlet weak var dividerView3: UIView!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 22
        cardContainerView.layer.cornerRadius = 18
        cardContainerView.layer.borderWidth = 0.5
        cardContainerView.layer.borderColor = UIColor(hex: "#22FFFFFF").cgColor//.withAlphaComponent(0.20).cgColor // #33FF1744
        cardContainerView.clipsToBounds = true
    }
    
    // MARK: - UI
    
    func setupUI() {
        
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        //        cardContainerView.backgroundColor = UIColor(red: 28/255, green: 34/255, blue: 56/255, alpha: 1)
        
        //        dividerView1.backgroundColor = UIColor.white.withAlphaComponent(0.12)
        //        dividerView2.backgroundColor = UIColor.white.withAlphaComponent(0.12)
        
        self.titleLbl.text = AppStrings.Redeem_Info
        
        //        bonusImageView.image = UIImage(named: "ic_bonus")
        //        occasionImageView.image = UIImage(named: "ic_special")
        //        retailImageView.image = UIImage(named: "ic_retail")
        
        earnPointsTitleLbl.text = AppStrings.earnPoints
        earnPointsSubTitleLbl.text = AppStrings.earnPoints_sub
        voucherTitleLbl.text = AppStrings.VoucherTitle
        voucherSubTitleLbl.text = AppStrings.Voucher_sub
        redeemTitleLbl.text = AppStrings.redeemPoints
        redeemSubTitleLbl.text = AppStrings.redeemPoints_sub
        enjoyTitleLbl.text = AppStrings.Enjoy
        enjoySubTitleLbl.text = AppStrings.Enjoy_sub
        
        
        
        [earnPointsTitleLbl, earnPointsSubTitleLbl, voucherTitleLbl, voucherSubTitleLbl, redeemTitleLbl, redeemSubTitleLbl, enjoyTitleLbl, enjoySubTitleLbl].forEach {
            $0?.numberOfLines = 0
            $0?.textAlignment = .center
        }
    }
}
