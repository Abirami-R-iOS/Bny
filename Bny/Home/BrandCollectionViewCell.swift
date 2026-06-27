//
//  DealCollectionViewCell.swift
//  Bny
//
//  Created by Abirami on 24/06/26.
//

import UIKit

class BrandCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var dealImageView: UIImageView!
    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subtitleLbl: UILabel!
    
    var favouriteAction: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    func setupUI() {
        self.cardView.layer.cornerRadius = 20
        self.cardView.clipsToBounds = true
        self.dealImageView.layer.cornerRadius = 20
        self.dealImageView.contentMode = .scaleAspectFill
        self.dealImageView.clipsToBounds = true
        
    }
    
    @IBAction func favouriteBtnAction(_ sender: Any) {
        self.favouriteAction?()
    }
    
}
