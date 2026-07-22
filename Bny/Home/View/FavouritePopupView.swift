//
//  FavouritePopupView.swift
//  Bny
//
//  Created by Abirami on 24/06/26.
//

import Foundation
import UIKit

class FavouritePopupView: UIView {
//    @IBOutlet weak var contentView: UIView!

//    @IBOutlet weak var iconBgView: UIView!

    @IBOutlet weak var iconImageView: UIImageView!

    @IBOutlet weak var titleLbl: UILabel!

    @IBOutlet weak var descriptionLbl: UILabel!

    @IBOutlet weak var cancelBtn: UIButton!

    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet weak var contentView: UIView!
    //    @IBOutlet weak var actionBtn: UIButton!
    var cancelHandler: (() -> Void)?

    var actionHandler: (() -> Void)?
    
    func configure(title: String, message: String, isFavourite: Bool = false, isFromLogout: Bool = false) {
        self.titleLbl.text = title
        self.descriptionLbl.text = message
        self.contentView.layer.cornerRadius = 30
        self.contentView.layer.shadowColor = UIColor.black.cgColor
        self.contentView.layer.shadowOpacity = 0.35
        self.contentView.layer.shadowRadius = 18
        self.contentView.layer.shadowOffset = CGSize(width: 0, height: 8)
        if isFromLogout {
            self.addBtn.setTitle("Logout", for: .normal)
        } else {
            if isFavourite {
                self.iconImageView.image = UIImage(named: "Delete_Icon")
                self.addBtn.setTitle("Remove", for: .normal)
                
            } else {
                self.iconImageView.image = UIImage(named: "Heart_Icon")
                self.addBtn.setTitle("Add", for: .normal)
            }
        }
    }
    @IBAction func cancelAction(_ sender: Any) {
        self.cancelHandler?()
    }
    @IBAction func addAction(_ sender: Any) {
        self.actionHandler?()
    }
}
