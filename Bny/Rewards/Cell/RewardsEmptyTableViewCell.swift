//
//  RewardsEmptyTableViewCell.swift
//  Bny
//
//  Created by Abirami on 29/06/26.
//

import UIKit

class RewardsEmptyTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var emptyImageView: UIImageView!

    @IBOutlet weak var titleLbl: UILabel!


    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()

        self.setupUI()
    }

    // MARK: - UI

    func setupUI() {

        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear

        self.titleLbl.text = AppStrings.No_Rewards_Title
    }

    // MARK: - Configure

    func configure(
        image: String = "ic_no_rewards",
        title: String = AppStrings.No_Rewards_Title
    ) {

        self.emptyImageView.image = UIImage(named: image)
        self.titleLbl.text = title
    }
}
