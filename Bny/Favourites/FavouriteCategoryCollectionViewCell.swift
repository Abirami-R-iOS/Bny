//
//  FavouriteCategoryCollectionViewCell.swift
//  Bny
//
//  Created by Abirami on 04/07/26.
//

import UIKit

class FavouriteCategoryCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var categoryTitleLbl: UILabel!
    @IBOutlet weak var countLbl: UILabel!

    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.containerView.layer.cornerRadius = 24
        self.containerView.clipsToBounds = true
        self.favouriteBtn.layer.cornerRadius = self.favouriteBtn.frame.height / 2
    }

    // MARK: - UI

    func setupUI() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.categoryImageView.contentMode = .scaleAspectFill
        self.categoryImageView.clipsToBounds = true
        self.favouriteBtn.tintColor = .white
        self.categoryTitleLbl.font = .poppinsSemiBold(size: 18)
        self.countLbl.font = .poppinsRegular(size: 16)
    }

    // MARK: - Configure

    func configure(image: String?, title: String, description: String, isFavourite: Int = 0) {
       
            guard let imageStr = image else {
                self.categoryImageView.image = UIImage(named: "Placeholder")
                return
            }
            let imageURL = APIConstants.baseURLImage + imageStr
            self.categoryImageView.loadImage(
                from: imageURL,
                placeholder: UIImage(named: "Placeholder")
            )
            
//            self.categoryImageView.image = UIImage(named: imageStr)
        
        self.categoryTitleLbl.text = title
        self.countLbl.text = description
        let imageName = isFavourite == 1 ? "Fav_Fill" : "heart"
        self.favouriteBtn.setImage(UIImage(systemName: imageName), for: .normal)
    }

    // MARK: - Actions

    @IBAction func favouriteTapped(_ sender: UIButton) {

    }
}
