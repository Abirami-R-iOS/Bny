//
//  ColorExtension.swift
//  Bny
//
//  Created by Abirami on 23/05/26.
//

import Foundation
import UIKit

extension UIColor {

    convenience init(hex: String) {

        let hex = hex.trimmingCharacters(in: .alphanumerics.inverted)

        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let r, g, b: UInt64

        switch hex.count {

        case 6:
            (r, g, b) = (
                int >> 16,
                int >> 8 & 0xFF,
                int & 0xFF
            )

        default:
            (r, g, b) = (0, 0, 0)
        }

        self.init(
            red: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue: CGFloat(b) / 255,
            alpha: 1
        )
    }
}
