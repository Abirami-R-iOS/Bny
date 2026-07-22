//
//  BrandDetailViewController.swift
//  Bny
//
//  Created by Abirami on 17/07/26.
//

import UIKit

class BrandDetailViewController: UIViewController {
    
    @IBOutlet weak var backContainerView: UIView!
    @IBOutlet weak var backBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpUI()
    }
    
    func setUpUI() {
        UIView.setUpBackView(view: backContainerView)
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        UIView.animateBackButton(view: self.backContainerView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            for vc in self.navigationController?.viewControllers ?? [] {
                if let brandListVC = vc as? BrandListViewController {
//                    brandListVC.isLoggedIn = UserSession.shared.isLoggedIn
                    self.navigationController?.popToViewController(brandListVC, animated: true)
                }
            }
            
//            self.navigationController?.popViewController(animated: true)
        }
    }
}
