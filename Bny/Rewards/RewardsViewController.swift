//
//  RewardsViewController.swift
//  Bny
//
//  Created by Abirami on 28/06/26.
//

//
//  RewardsViewController.swift
//  Bny
//

import UIKit

class RewardsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var noDataView: UIView!
    
    @IBOutlet weak var noDataLbl: UILabel!
    @IBOutlet weak var noDataImageView: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var subTitleLbl: UILabel!
    
    @IBOutlet weak var backContainerView: UIView!
    
    @IBOutlet weak var tabContainerView: UIView!
    
    @IBOutlet weak var rewardsBtn: UIButton!
    
    @IBOutlet weak var specialsBtn: UIButton!
    
    @IBOutlet weak var historyBtn: UIButton!
    
    @IBOutlet weak var RewardsTableView: UITableView!
    
    // MARK: - Variables
    
    var selectedTab: RewardTab = .rewards
    var rewards = [1,2,3]
    var history = [Int]()
    var specials = [Int]()
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
        self.setupTableView()
        
        self.updateTabs()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        mainView.applyRewardBackgroundGradient()
        tabContainerView.applyTabParentStyle()

        updateTabs() // button bounds கிடைத்த பிறகு gradient apply ஆகும்
    }
    
    // MARK: - UI
    
    func setupUI() {
        
        self.titleLbl.text = AppStrings.Rewards_Title
        
        self.subTitleLbl.text = AppStrings.Rewards_SubTitle
        
        self.tabContainerView.layer.cornerRadius = 20
        
        self.tabContainerView.layer.borderWidth = 1
        
        self.tabContainerView.layer.borderColor = UIColor.whiteClr.withAlphaComponent(0.12).cgColor
        
        self.rewardsBtn.setTitle(RewardTab.rewards.title, for: .normal)
        
        self.specialsBtn.setTitle(RewardTab.specials.title, for: .normal)
        
        self.historyBtn.setTitle(RewardTab.history.title, for: .normal)
        
        [self.rewardsBtn, self.specialsBtn, self.historyBtn].forEach {
//            $0?.titleLabel?.font = UIFont(name: "poppins_medium", size: 12)
            $0?.titleLabel?.font = .poppinsMedium(size: 12)
            $0?.layer.cornerRadius = 12
            $0?.clipsToBounds = true
        }
        
        self.setUpBackView()
    }
    
    func setUpBackView() {
        
        self.backContainerView.layer.cornerRadius = self.backContainerView.frame.height / 2
        
        self.backContainerView.layer.masksToBounds = true
        
        self.backContainerView.layer.borderWidth = 1
        
        self.backContainerView.layer.borderColor = UIColor.whiteClr.withAlphaComponent(0.12).cgColor
    }
    
    func setupTableView() {
        self.RewardsTableView.rowHeight = UITableView.automaticDimension

        self.RewardsTableView.estimatedRowHeight = 220
        
        self.RewardsTableView.delegate = self
        
        self.RewardsTableView.dataSource = self
        
        self.RewardsTableView.separatorStyle = .none
        
        self.RewardsTableView.backgroundColor = .clear
        
        self.RewardsTableView.showsVerticalScrollIndicator = false
        
        self.RewardsTableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 20, right: 0)
        
        let rewardsNib = UINib(nibName: "RewardsTableViewCell", bundle: nil)
        
        self.RewardsTableView.register(rewardsNib, forCellReuseIdentifier: "RewardsTableViewCell")
        
        let specialsNib = UINib(nibName: "SpecialsTableViewCell", bundle: nil)
        
        self.RewardsTableView.register(specialsNib, forCellReuseIdentifier: "SpecialsTableViewCell")
        
        let historyNib = UINib(nibName: "HistoryTableViewCell", bundle: nil)
        
        self.RewardsTableView.register(historyNib, forCellReuseIdentifier: "HistoryTableViewCell")
        
        let bannerNib = UINib(nibName: "RewardsBannerTableViewCell",bundle: nil)

        self.RewardsTableView.register(bannerNib, forCellReuseIdentifier: "RewardsBannerTableViewCell" )
        
        self.RewardsTableView.register(UINib(nibName: "RewardsOccasionTableViewCell", bundle: nil), forCellReuseIdentifier: "RewardsOccasionTableViewCell")
        
        self.RewardsTableView.register(UINib(nibName: "RewardsHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "RewardsHeaderTableViewCell")
        
        self.RewardsTableView.register(UINib(nibName: "RewardsInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "RewardsInfoTableViewCell")
        
        self.RewardsTableView.register(
            UINib(nibName: "RewardsEmptyTableViewCell", bundle: nil),
            forCellReuseIdentifier: "RewardsEmptyTableViewCell")
        self.RewardsTableView.register(
                UINib(nibName: "HistoryItemTableViewCell", bundle: nil),
                forCellReuseIdentifier: "HistoryItemTableViewCell")
    }
    
    func updateTabs() {
        
        self.resetButtons()
        
        switch self.selectedTab {
            
        case .rewards:
            
            self.selectButton(self.rewardsBtn)
            
        case .specials:
            
            self.selectButton(self.specialsBtn)
            
        case .history:
            
            self.selectButton(self.historyBtn)
        }
    }
    
    func resetButtons() {

        let buttons = [
            rewardsBtn,
            specialsBtn,
            historyBtn
        ]

        buttons.forEach {

            $0?.removeSelectedTabGradient()
            $0?.backgroundColor = .clear
            $0?.setTitleColor(.silverClr, for: .normal)
        }
    }
    
    func selectButton(_ button: UIButton) {
        
        button.applySelectedTabGradient()
        
        button.setTitleColor(.whiteClr, for: .normal)
    }
    
    // MARK: - Actions
    
    @IBAction func rewardsTapped(_ sender: UIButton) {
        
        self.selectedTab = .rewards
        
        self.updateTabs()
        
        self.RewardsTableView.reloadData()
    }
    
    @IBAction func specialsTapped(_ sender: UIButton) {
        
        self.selectedTab = .specials
        
        self.updateTabs()
        
        self.RewardsTableView.reloadData()
    }
    
    @IBAction func historyTapped(_ sender: UIButton) {
        
        self.selectedTab = .history
        
        self.updateTabs()
        
        self.RewardsTableView.reloadData()
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        
        self.navigateBack(sender: sender)
    }
}

extension RewardsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch self.selectedTab {

        case .rewards:

            return self.rewards.isEmpty ? 5 : self.rewards.count + 4//6

        case .specials:

            return 3

        case .history:

            return history.isEmpty ? 3 : history.count + 2
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch self.selectedTab {

        case .rewards:

            switch indexPath.row {

            case 0:

                let cell = tableView.dequeueReusableCell(withIdentifier: "RewardsBannerTableViewCell", for: indexPath) as! RewardsBannerTableViewCell
                cell.configure()
                return cell

            case 1:

                let cell = tableView.dequeueReusableCell(withIdentifier: "RewardsOccasionTableViewCell", for: indexPath) as! RewardsOccasionTableViewCell
                return cell

            case 2:

                let cell = tableView.dequeueReusableCell(withIdentifier: "RewardsHeaderTableViewCell", for: indexPath) as! RewardsHeaderTableViewCell

                cell.viewAllAction = { [weak self] in
                    guard let self else { return }
                    // Navigate
                }

                return cell

            default:

                if self.rewards.isEmpty {

                    if indexPath.row == 3 {

                        let cell = tableView.dequeueReusableCell(withIdentifier: "RewardsEmptyTableViewCell", for: indexPath) as! RewardsEmptyTableViewCell
                        cell.configure()
                        return cell

                    } else {

                        let cell = tableView.dequeueReusableCell(withIdentifier: "RewardsInfoTableViewCell", for: indexPath) as! RewardsInfoTableViewCell
                        return cell
                    }

                } else {

                    if indexPath.row == self.rewards.count + 3 {

                        let cell = tableView.dequeueReusableCell(withIdentifier: "RewardsInfoTableViewCell", for: indexPath) as! RewardsInfoTableViewCell
                        return cell

                    } else {

                        let colors: [UIColor] = [
                            UIColor(hex: "A22024"),
                            UIColor(hex: "ECA424"),
                            UIColor(hex: "1CBFB2")
                        ]

                        let color = colors[(indexPath.row - 3) % colors.count]

                        let cell = tableView.dequeueReusableCell(withIdentifier: "RewardsTableViewCell", for: indexPath) as! RewardsTableViewCell

                        cell.configure(
                            image: "Deal1",
                            title: "LUXURY WATCHES",
                            location: "Tambaram",
                            amount: "$700",
                            color: color
                        )

                        return cell
                    }
                }

            }


        case .history:

            switch indexPath.row {

            case 0:

                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "HistoryTableViewCell",
                    for: indexPath
                ) as! HistoryTableViewCell
                cell.configure()
                return cell

            case 1:

                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "RewardsHeaderTableViewCell",
                    for: indexPath
                ) as! RewardsHeaderTableViewCell

                cell.titleLbl.text = AppStrings.Your_History
                cell.viewAllBtn.isHidden = true

                return cell

            default:

                if history.isEmpty {

                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: "RewardsEmptyTableViewCell",
                        for: indexPath
                    ) as! RewardsEmptyTableViewCell

                    cell.configure(
                        title: AppStrings.No_History_Title
                    )

                    return cell

                } else {

                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: "RewardsTableViewCell",
                        for: indexPath
                    ) as! RewardsTableViewCell

                    return cell
                }
            }
        case .specials:
            switch indexPath.row {
                
            case 0:

                let cell = tableView.dequeueReusableCell(withIdentifier: "SpecialsTableViewCell", for: indexPath) as! SpecialsTableViewCell
                
                return cell

            case 1:

                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "RewardsHeaderTableViewCell",
                    for: indexPath
                ) as! RewardsHeaderTableViewCell

                cell.titleLbl.text = AppStrings.Your_Coupon
                cell.viewAllBtn.isHidden = true

                return cell

            default:

                if specials.isEmpty {

                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: "RewardsEmptyTableViewCell",
                        for: indexPath
                    ) as! RewardsEmptyTableViewCell

                    cell.configure(
                        title: AppStrings.nocoupons
                    )

                    return cell

                } else {

                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: "RewardsTableViewCell",
                        for: indexPath
                    ) as! RewardsTableViewCell

                    return cell
                }
            }
        }
    }
    
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        switch selectedTab {
//            
//        case .rewards:
//            switch indexPath.row {
//            case 0:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "RewardsBannerTableViewCell", for: indexPath) as! RewardsBannerTableViewCell
//                cell.configure()
//                return cell
//                
//            case 1:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "RewardsOccasionTableViewCell", for: indexPath) as! RewardsOccasionTableViewCell
//                return cell
//                
//            case 2:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "RewardsHeaderTableViewCell", for: indexPath) as! RewardsHeaderTableViewCell
//                cell.viewAllAction = { [weak self] in
//                    guard let self else { return }
//                    
//                    // Navigate to Rewards List Screen
//                }
//                
//                return cell
//                
//            case 6:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "RewardsInfoTableViewCell", for: indexPath) as! RewardsInfoTableViewCell
//                return cell
//                
//                //            case 5:
//                //                let cell = tableView.dequeueReusableCell(withIdentifier: "RewardsTableViewCell", for: indexPath) as! RewardsTableViewCell
//                //                cell.configure(image: "Deal1", title: "LUXURY WATCHES", location: "Tambaram", amount: "$700", color: UIColor(hex: "1CBFB2"))
//                //                return cell
//                //
//                //            case 3:
//                //                let cell = tableView.dequeueReusableCell(withIdentifier: "RewardsTableViewCell", for: indexPath) as! RewardsTableViewCell
//                //                cell.configure(image: "Deal1", title: "LUXURY WATCHES", location: "Tambaram", amount: "$700", color: UIColor(hex: "ECA424"))
//                //                return cell
//                //
//                //            default:
//                //                let cell = tableView.dequeueReusableCell(withIdentifier: "RewardsTableViewCell", for: indexPath) as! RewardsTableViewCell
//                //                cell.configure(image: "Deal1", title: "LUXURY WATCHES", location: "Tambaram", amount: "$700", color: UIColor(hex: "A22024"))
//                //                return cell
//                
//                
//            default:
//                if rewards.isEmpty {
//                    
//                    if indexPath.row == 3 {
//                        
//                        // Empty Cell
//                        
//                    } else {
//                        
//                        // How It Works
//                    }
//                    
//                } else {
//                    
//                    if indexPath.row == rewards.count + 3 {
//                        
//                        // How It Works
//                        
//                    } else {
//                        
//                        // Reward Cell
//                    }
//                    
//                }
//            }
//            
//            
//            //            switch indexPath.row {
//            //            case 0:
//            //                let cell = tableView.dequeueReusableCell(withIdentifier: "RewardsBannerTableViewCell", for: indexPath) as! RewardsBannerTableViewCell
//            //                cell.configure()
//            //                return cell
//            //
//            //            default:
//            //                let cell = tableView.dequeueReusableCell(withIdentifier: "RewardsTableViewCell", for: indexPath) as! RewardsTableViewCell
//            //                cell.configure(image: "Deal1", title: "Luxury Watches", location: "Chennai", amount: "₹1000", color: .systemTeal)
//            //                return cell
//            //            }
//            
//        case .specials:
//            
//            let cell = tableView.dequeueReusableCell(withIdentifier: "SpecialsTableViewCell", for: indexPath) as! SpecialsTableViewCell
//            
//            return cell
//            
//        case .history:
//            
//            let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
//            
//            return cell
//        }
//    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch selectedTab {
//        case .rewards:
//            switch indexPath.row {
//            case 0: return 150   // Banner
//            case 1: return 180   // Occasion
//            case 2: return 30    // Header
//            case 6: return 180    //RewardInfo
//            default: return 150  // Reward Cell
//            }
//        case .specials:
//            return 300
//        case .history:
//            return 220
//        }
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch self.selectedTab {

        case .rewards:

            switch indexPath.row {

            case 0:
                return 150

            case 1:
                return 180

            case 2:
                return 30

            default:

                if self.rewards.isEmpty {

                    if indexPath.row == 3 {
                        return 230
                    } else {
                        return 180
                    }

                } else {

                    if indexPath.row == self.rewards.count + 3 {
                        return 180
                    } else {
                        return 150
                    }
                }
            }

        case .history:

            switch indexPath.row {

            case 0:
                return 150

            case 1:
                return 30

            default:

                if history.isEmpty {
                    return 230
                } else {
                    return 150
                }
            }
        case .specials:
            switch indexPath.row {

            case 0:
                return 150

            case 1:
                return 30

            default:

                if specials.isEmpty {
                    return 230
                } else {
                    return 150
                }
            }
        }
    }

    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        switch indexPath.row {
//
//        case 0:
//            return 180
//
//        case 1:
//            return 180
//
//        case 2:
//            return 50
//
//        default:
//            return 180
//        }
//    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 300
    }
}

