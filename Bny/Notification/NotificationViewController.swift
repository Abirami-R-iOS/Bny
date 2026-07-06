//
//  NotificationViewController.swift
//  Bny
//
//  Created by Abirami on 01/07/26.
//

import UIKit

class NotificationViewController: UIViewController {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var backContainerView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var notificationTableView: UITableView!
    
    // MARK: - Variables
    
    var notifications = [
        (
            image: "Deal1",
            title: "Special Weekend Offer!",
            description: "Pizza Hub is offering 50% OFF on all pizzas. Order now and enjoy!",
            time: "2m ago",
            color: UIColor.systemYellow,
            unread: true
        ),
        (
            image: "Deal1",
            title: "Flat ₹500 Cashback",
            description: "Get instant cashback on grocery purchases above ₹2000.",
            time: "10m ago",
            color: UIColor.systemRed,
            unread: true
        ),
        (
            image: "Deal1",
            title: "Fashion Mega Sale",
            description: "Flat 70% OFF on selected fashion brands today only.",
            time: "1h ago",
            color: UIColor.systemTeal,
            unread: false
        ),
        (
            image: "Deal1",
            title: "New Shop Added",
            description: "A new premium restaurant has been added near your location.",
            time: "3h ago",
            color: UIColor.systemPurple,
            unread: false
        )
    ]
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
        self.setupTableView()
    }
    
    // MARK: - UI
    
    func setupUI() {
        
        self.titleLbl.text = "Notifications"
        
        self.subTitleLbl.text = "Stay updated with latest offers"
        
        self.setUpBackView()
    }
    
    func setUpBackView() {
        
        self.backContainerView.layer.cornerRadius = self.backContainerView.frame.height / 2
        
        self.backContainerView.layer.masksToBounds = true
        
        self.backContainerView.layer.borderWidth = 1
        
        self.backContainerView.layer.borderColor = UIColor.whiteClr.withAlphaComponent(0.12).cgColor
    }
    
    func setupTableView() {
        
        self.notificationTableView.delegate = self
        
        self.notificationTableView.dataSource = self
        
        self.notificationTableView.separatorStyle = .none
        
        self.notificationTableView.backgroundColor = .clear
        
        self.notificationTableView.rowHeight = UITableView.automaticDimension
        
        self.notificationTableView.estimatedRowHeight = 156
        
        self.notificationTableView.showsVerticalScrollIndicator = false
        
        self.notificationTableView.register(
            UINib(nibName: "NotificationTableViewCell", bundle: nil),
            forCellReuseIdentifier: "NotificationTableViewCell"
        )
    }
    
    // MARK: - Actions
    
    @IBAction func backTapped(_ sender: UIButton) {
        
        self.navigateBack(sender: sender)
    }
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = self.notifications[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "NotificationTableViewCell",
            for: indexPath
        ) as! NotificationTableViewCell
        
        cell.configure(
            image: item.image,
            title: item.title,
            description: item.description,
            time: item.time,
            indicatorColor: item.color,
            isUnread: item.unread
        )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Navigate to Notification Detail
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 156
    }
}
