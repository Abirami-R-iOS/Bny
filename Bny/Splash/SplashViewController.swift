//
//  SplashViewController.swift
//  Bny
//
//  Created by Abirami on 23/05/26.
//

import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet weak var bnyLbl: UILabel!
    @IBOutlet weak var subtitleLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var hyphenView: UIView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var locationImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigateToWelcome()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.setText()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animateLocationPin()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.subView.applyGradient(
            colors: [
                UIColor(named: "gradientTop")!,
                UIColor(named: "gradientBottom")!
            ],
            cornerRadius: 28,
            cornerStyle: .custom([
                .layerMinXMinYCorner,
                .layerMaxXMinYCorner
            ])
        )
    }
    
    func navigateToWelcome() {

        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {

            let vc = self.storyboard?.instantiateViewController(
                withIdentifier: "WelcomeViewController"
            ) as! WelcomeViewController

            self.navigationController?.pushViewController(
                vc,
                animated: true
            )
        }
    }
    
    func setText() {
        self.titleLbl.text = AppStrings.Whenever_You_Shop
        self.subtitleLbl.text = AppStrings.Get_exclusive_Discounts
        self.bnyLbl.text = AppStrings.Brands_Near_you.uppercased()
    }
    
    func animateLocationPin() {
        
        self.locationImageView.alpha = 0.0
        self.locationImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(
            withDuration: 2.5,
            delay: 0,
            usingSpringWithDamping: 0.55,
            initialSpringVelocity: 0.8,
            options: [.curveEaseOut],
            animations: {
                
                self.locationImageView.alpha = 1.0
                self.locationImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                
            }, completion: { _ in
                
                UIView.animate(
                    withDuration: 0.6,
                    delay: 0,
                    usingSpringWithDamping: 0.4,
                    initialSpringVelocity: 1.2,
                    options: [.curveEaseOut],
                    animations: {
                        
                        self.locationImageView.transform = .identity
                        
                    }, completion: { _ in
                        
                        // SAFE NAVIGATION
                        // Navigate next screen here
                        
                    })
            })
        
    }
}
