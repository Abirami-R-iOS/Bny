//
//  UIFontExtension.swift
//  Bny
//
//  Created by Abirami on 25/05/26.
//

import Foundation
import UIKit

extension UIFont {

    static func poppinsRegular(
        size: CGFloat
    ) -> UIFont {

        return UIFont(
            name: "poppins_regular",
            size: size
        ) ?? UIFont.systemFont(
            ofSize: size
        )
    }

    static func poppinsMedium(
        size: CGFloat
    ) -> UIFont {

        return UIFont(
            name: "poppins_medium",
            size: size
        ) ?? UIFont.systemFont(
            ofSize: size,
            weight: .medium
        )
    }

    static func poppinsSemiBold(
        size: CGFloat
    ) -> UIFont {

        return UIFont(
            name: "poppins_semibold",
            size: size
        ) ?? UIFont.systemFont(
            ofSize: size,
            weight: .semibold
        )
    }

    static func poppinsBold(
        size: CGFloat
    ) -> UIFont {

        return UIFont(
            name: "poppins_bold",
            size: size
        ) ?? UIFont.systemFont(
            ofSize: size,
            weight: .bold
        )
    }
}
