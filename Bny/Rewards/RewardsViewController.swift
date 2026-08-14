//
//  RewardsViewController.swift
//  Bny
//
//  Created by Abirami on 28/06/26.
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
    let viewModel = RewardsViewModel()
    var selectedTab: RewardTab = .rewards
    var history = [RewardData]()
    var specials = [Int]()
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        self.setupUI()
        self.setupTableView()
        self.updateTabs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateTabs()
        self.viewModel.getRewards()
        self.viewModel.getHistory()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //        mainView.applyRewardBackgroundGradient()
        tabContainerView.applyTabParentStyle()
        
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
            let font = UIFont.poppinsMedium(size: 14)
            $0?.titleLabel?.font = font
            $0?.clipsToBounds = true
            $0?.layer.cornerRadius = 12
            $0?.setButtonFont(size: 14, font: font)
            
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
            $0?.setTitleColor(.profileDescClr, for: .normal)
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
            
            return self.viewModel.rewards.isEmpty ? 5 : min(self.viewModel.rewards.count, 3) + 4//6
            
        case .specials:
            
            return 3
            
        case .history:
            
            return self.viewModel.history.isEmpty ? 3 : self.viewModel.history.count + 2
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
                
                cell.configure(title: AppStrings.Your_Rewards, buttonTitle: AppStrings.View_All, showViewAll: self.viewModel.rewards.count > 3)
                cell.viewAllAction = { [weak self] in
                    // Navigate
                }
                
                return cell
                
            default:
                
                if self.viewModel.rewards.isEmpty {
                    
                    if indexPath.row == 3 {
                        
                        let cell = tableView.dequeueReusableCell(withIdentifier: "RewardsEmptyTableViewCell", for: indexPath) as! RewardsEmptyTableViewCell
                        cell.configure()
                        return cell
                        
                    } else {
                        
                        let cell = tableView.dequeueReusableCell(withIdentifier: "RewardsInfoTableViewCell", for: indexPath) as! RewardsInfoTableViewCell
                        return cell
                    }
                    
                } else {
                    
                    if indexPath.row == min(self.viewModel.rewards.count,3) + 3 {
                        
                        let cell = tableView.dequeueReusableCell(withIdentifier: "RewardsInfoTableViewCell", for: indexPath) as! RewardsInfoTableViewCell
                        return cell
                        
                    } else {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "RewardsTableViewCell", for: indexPath) as! RewardsTableViewCell
                        
                        let rewardIndex = indexPath.row - 3
                        guard rewardIndex >= 0,
                              rewardIndex < self.viewModel.rewards.count else {
                            return UITableViewCell()
                        }
                        
                        let rewardsData = self.viewModel.rewards[rewardIndex]
                        
                        
                        
                        cell.configure(image: rewardsData.store?.logo ?? "", title: rewardsData.store?.name ?? "", location: rewardsData.store?.area ?? "", amount: "\((rewardsData.currency ?? "") + (rewardsData.rewardValue ?? ""))", color: rewardsData.colorCode ?? "",offerValueLbl: AppStrings.offerValid, offerValueLblValue: rewardsData.rewardValue ?? "")
                        
                        cell.redeemAction = { [weak self] in
                            guard let self = self else { return }
                            
                            let vc = self.storyboard?.instantiateViewController(
                                withIdentifier: "RewardVoucherViewController"
                            ) as? RewardVoucherViewController
                            
                            guard let vc else { return }
                            
                            self.navigationController?.pushViewController(
                                vc,
                                animated: true
                            )
                        }
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
                
                if self.viewModel.history.isEmpty {
                    
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
                        withIdentifier: "HistoryItemTableViewCell",
                        for: indexPath
                    ) as! HistoryItemTableViewCell
                    
                    
                    let historyData = self.viewModel.history[indexPath.row - 2]
                    
                    cell.configure(image: historyData.store?.logo ?? "", title: historyData.store?.name ?? "", location: historyData.store?.area ?? "", amount: "\((historyData.currency ?? "") + (historyData.rewardValue ?? ""))", color: historyData.colorCode ?? "", redeemedCode: historyData.rewardCode ?? "", giftedOn: historyData.validity ?? "", status: HistoryStatus(rawValue: historyData.status ?? ""), claimedId: historyData.claimedId, userId: UserSession.shared.userId)
                    
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
                
                if self.viewModel.rewards.isEmpty {
                    
                    if indexPath.row == 3 {
                        return 230
                    } else {
                        return 180
                    }
                    
                } else {
                    
                    if indexPath.row == min(self.viewModel.rewards.count,3) + 3 {
                        return 150
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
                
                if self.viewModel.history.isEmpty {
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
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 300
    }
}

extension RewardsViewController: RewardViewModelDelegate {
    func didReceiveHistory() {
        print(self.viewModel.history)
        self.RewardsTableView.reloadData()
    }
    
    func didReceiveHistoryError(_ message: String) {
        print(message)
    }
    
    func didReceiveRewards() {
        
        print(self.viewModel.rewards)
        
        self.RewardsTableView.reloadData()
    }
    
    func didReceiveRewardsError(_ message: String) {
        
        print(message)
    }
}
