//
//  UIButtonExtension.swift
//  Bny
//
//  Created by Abirami on 14/08/26.
//

import Foundation
import UIKit

extension UIButton {

    func setButtonFont(size: CGFloat, font: UIFont) {
        self.titleLabel?.font = font

        self.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attributes in
            var attributes = attributes
            attributes.font = font
            return attributes
        }
    }
}
