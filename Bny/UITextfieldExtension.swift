//
//  UITextfieldExtension.swift
//  Bny
//
//  Created by Abirami on 25/05/26.
//

import Foundation
import UIKit

extension UITextField {

    func addDoneButton(
        target: Any,
        action: Selector
    ) {

        let toolbar = UIToolbar()

        toolbar.sizeToFit()

        toolbar.backgroundColor =
            UIColor(
                white: 0.1,
                alpha: 0.95
            )

        toolbar.isTranslucent = false

        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )

        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: target,
            action: action
        )

        doneButton.tintColor = UIColor.gradientTop

        toolbar.items = [
            flexSpace,
            doneButton
        ]

        self.inputAccessoryView = toolbar
    }
}
