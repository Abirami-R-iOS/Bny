//
//  FavouriteBrandCollectionViewCell.swift
//  Bny
//
//  Created by Abirami on 07/07/26.
//

//
//  FavouriteBrandCollectionViewCell.swift
//  Bny
//
//  Created by Abirami on 07/07/26.
//

import UIKit

class FavouriteBrandCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets

    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var brandImageView: UIImageView!

    @IBOutlet weak var favouriteBtn: UIButton!

    @IBOutlet weak var titleLbl: UILabel!

    @IBOutlet weak var subTitleLbl: UILabel!

    @IBOutlet weak var locationImageView: UIImageView!

    @IBOutlet weak var distanceLbl: UILabel!

    // MARK: - Variables

    var favouriteAction: (() -> Void)?

    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()

        self.setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.containerView.layer.cornerRadius = 24

        self.brandImageView.layer.cornerRadius = self.brandImageView.frame.height / 2

        self.favouriteBtn.layer.cornerRadius = self.favouriteBtn.frame.height / 2
    }

    // MARK: - UI

    func setupUI() {

        self.backgroundColor = .clear

        self.contentView.backgroundColor = .clear

        self.containerView.clipsToBounds = true

        self.brandImageView.clipsToBounds = true

        self.favouriteBtn.clipsToBounds = true

        self.containerView.layer.borderWidth = 1

        self.containerView.layer.borderColor = UIColor.whiteClr.withAlphaComponent(0.08).cgColor

        self.locationImageView.image = UIImage(systemName: "location.fill")

        self.locationImageView.tintColor = .silverClr
    }

    // MARK: - Configure

    func configure(image: String, title: String, subTitle: String, distance: String) {

        self.brandImageView.image = UIImage(named: image)

        self.titleLbl.text = title

        self.subTitleLbl.text = subTitle

        self.distanceLbl.text = distance
    }

    // MARK: - Actions

    @IBAction func favouriteTapped(_ sender: UIButton) {

        self.favouriteAction?()
    }
}
