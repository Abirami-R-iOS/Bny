//
//  NotificationTableViewCell.swift
//  Bny
//
//  Created by Abirami on 01/07/26.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var leftIndicatorView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var statusDotView: UIView!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.containerView.layer.cornerRadius = 24
        self.containerView.layer.borderWidth = 1
        self.containerView.layer.borderColor = UIColor.whiteClr.withAlphaComponent(0.08).cgColor
        
        self.logoImageView.layer.cornerRadius = 16
        self.logoImageView.clipsToBounds = true
        
        self.leftIndicatorView.layer.cornerRadius = 2
        
        self.statusDotView.layer.cornerRadius = self.statusDotView.frame.height / 2
    }
    
    // MARK: - UI
    
    func setupUI() {
        
        self.selectionStyle = .none
        
//        self.backgroundColor = .clear
        
//        self.contentView.backgroundColor = .clear
        
        self.containerView.clipsToBounds = true
        
//        self.titleLbl.font = .poppinsSemiBold(size: 18)
//        
//        self.descriptionLbl.font = .poppinsRegular(size: 14)
//        
//        self.timeLbl.font = .poppinsRegular(size: 12)
        
//        self.titleLbl.textColor = .white
        
//        self.descriptionLbl.textColor = .silverClr
        
//        self.timeLbl.textColor = .silverClr
        
//        self.titleLbl.numberOfLines = 1
//        
//        self.descriptionLbl.numberOfLines = 2
    }
    
    // MARK: - Configure
    
    func configure(
        image: String,
        title: String,
        description: String,
        time: String,
        indicatorColor: UIColor,
        isUnread: Bool
    ) {
        
        self.logoImageView.image = UIImage(named: image)
        
        self.titleLbl.text = title
        
        self.descriptionLbl.text = description
        
        self.timeLbl.text = time
        
        self.leftIndicatorView.backgroundColor = indicatorColor
        
        self.statusDotView.backgroundColor = indicatorColor
        
        self.statusDotView.isHidden = !isUnread
    }
}
