//
//  RewardsHeaderTableViewCell.swift
//  Bny
//
//  Created by Abirami on 28/06/26.
//

import UIKit

class RewardsHeaderTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var viewAllBtn: UIButton!

    // MARK: - Variables

    var viewAllAction: (() -> Void)?

    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - UI

    func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        titleLbl.text = AppStrings.Your_Rewards
        
        viewAllBtn.titleLabel?.font = .poppinsMedium(size: 9.0)
        viewAllBtn.setTitle(AppStrings.View_All, for: .normal)
    }

    // MARK: - Actions

    @IBAction func viewAllTapped(_ sender: UIButton) {
        viewAllAction?()
    }
}
