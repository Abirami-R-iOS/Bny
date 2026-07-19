//
//  ViewController.swift
//  Bny
//
//  Created by Abirami on 22/05/26.
//

import UIKit

extension UIViewController {
    
    func navigateBack(sender: UIButton) {
        
        UIView.animate(withDuration: 0.15, animations: {
            
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            
        }) { _ in
            
            UIView.animate(withDuration: 0.15) {
                
                sender.transform = .identity
            }
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}
