//
//  BrandListCollectionViewCell.swift
//  Bny
//
//  Created by Abirami on 27/06/26.
//

import UIKit

class BrandListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var dealImageView: UIImageView!
    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var LocationLbl: UILabel!
    
    var favouriteAction: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    //commit test
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
    
    func configure(with brandList: BrandListResponseModel) {

        self.titleLbl.text = brandList.name
        self.LocationLbl.text = (brandList.area ?? "") + " | " + String(brandList.distance ?? 0) + "km"
        self.descriptionLbl.text = brandList.offerDescription

        self.dealImageView.image = brandList.image ?? UIImage(named: "Placeholder")

        let imageName = brandList.isFavourite == 1 ? "Fav_Fill" : "Fav_Unfill"

        self.favouriteBtn.setImage(UIImage(named: imageName), for: .normal)
    }
    
}
