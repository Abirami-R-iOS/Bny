//
//  HistoryTableViewCell.swift
//  Bny
//
//  Created by Abirami on 28/06/26.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    @IBOutlet weak var giftImageView: UIImageView!
    
    // MARK: - Variables
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.containerView.layer.cornerRadius = 24
        self.containerView.layer.masksToBounds = true
        self.containerView.layer.borderWidth = 1
        self.containerView.layer.borderColor = UIColor(hex: "#FF1744").withAlphaComponent(0.20).cgColor
        self.containerView.applyRewardBannerGradient()
    }
    
    // MARK: - UI
    
    func setupUI() {
        self.containerView.clipsToBounds = true
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        
        //        self.setupGradient()
        
//        self.titleLbl.text = AppStrings.History_Title
//        self.descriptionLbl.text = AppStrings.History_SubTitle
        
        //        self.giftImageView.image = UIImage(named: "Gift_box")
        self.giftImageView.contentMode = .scaleAspectFit
    }
    
    //    func setupGradient() {
    //
    //        self.gradientLayer.colors = [
    //            UIColor(hex: "#6F0D26").cgColor,
    //            UIColor(hex: "#B3123F").cgColor,
    //            UIColor(hex: "#E11D4F").cgColor
    //        ]
    //
    //        self.gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
    //        self.gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
    //
    //        if self.gradientLayer.superlayer == nil {
    //            self.containerView.layer.insertSublayer(
    //                self.gradientLayer,
    //                at: 0
    //            )
    //        }
    //    }
    
    // MARK: - Configure
    
    func configure() {
        
        self.titleLbl.text = AppStrings.History_Title
        self.descriptionLbl.text = AppStrings.History_SubTitle
        
        //        self.giftImageView.image = UIImage(named: "Gift_box")
       
        
        //        self.giftImageView.image = UIImage(named: "Gift_Box")
    }
}
