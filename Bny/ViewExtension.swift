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
}
