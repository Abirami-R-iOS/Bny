//
//  RewardsOccasionTableViewCell.swift
//  Bny
//
//  Created by Abirami on 28/06/26.
//

import UIKit

class RewardsOccasionTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var titleLbl: UILabel!

    @IBOutlet weak var cardContainerView: UIView!

    @IBOutlet weak var bonusView: UIView!
    @IBOutlet weak var bonusImageView: UIImageView!
    @IBOutlet weak var bonusTitleLbl: UILabel!

    @IBOutlet weak var occasionView: UIView!
    @IBOutlet weak var occasionImageView: UIImageView!
    @IBOutlet weak var occasionTitleLbl: UILabel!

    @IBOutlet weak var retailView: UIView!
    @IBOutlet weak var retailImageView: UIImageView!
    @IBOutlet weak var retailTitleLbl: UILabel!

    @IBOutlet weak var dividerView1: UIView!
    @IBOutlet weak var dividerView2: UIView!

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

        self.titleLbl.text = AppStrings.Gift_Voucher

//        bonusImageView.image = UIImage(named: "ic_bonus")
//        occasionImageView.image = UIImage(named: "ic_special")
//        retailImageView.image = UIImage(named: "ic_retail")

        bonusTitleLbl.text = AppStrings.Joining_Bonus
        occasionTitleLbl.text = AppStrings.Special_Occasions
        retailTitleLbl.text = AppStrings.Retail_Brand

        [bonusTitleLbl, occasionTitleLbl, retailTitleLbl].forEach {
            $0?.numberOfLines = 0
            $0?.textAlignment = .center
        }
    }
}
