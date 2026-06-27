//
//  WelcomeCollectionViewCell.swift
//  Bny
//
//  Created by Abirami on 23/05/26.
//

import UIKit

class WelcomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!

    @IBOutlet weak var titleLbl: UILabel!

    @IBOutlet weak var descLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(data: WelcomeModel) {

        self.bannerImageView.image = UIImage(named: data.image)

        self.titleLbl.text = data.title

        self.descLbl.text = data.description
    }
    
    
}
