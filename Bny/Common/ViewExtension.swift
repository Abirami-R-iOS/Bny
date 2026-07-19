//
//  ViewExtension.swift
//  Bny
//
//  Created by Abirami on 28/06/26.
//

import Foundation
import UIKit

extension UIView {
    static func animateBackButton(view: UIView) {

        UIView.animate(withDuration: 0.12, animations: {

            view.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)

            view.alpha = 0.8

        }) { _ in

            UIView.animate(withDuration: 0.12) {

                view.transform = .identity

                view.alpha = 1
            }
        }
    }
    
    static func setUpBackView(view: UIView) {
        view.layer.cornerRadius = view.frame.height / 2
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.whiteClr.withAlphaComponent(0.12).cgColor
    }
}
