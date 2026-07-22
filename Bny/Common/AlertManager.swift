//
//  AlertManager.swift
//  Bny
//
//  Created by Abirami on 31/05/26.
//

import Foundation
import UIKit

final class AlertManager {

    static func showAlert(
        on vc: UIViewController,
        title: String = "",
        message: String = "",
        buttonTitle: String = "OK",
        completion: (() -> Void)? = nil
    ) {

        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(
                title: buttonTitle,
                style: .default, handler: { _ in
                    completion?()
                }
            )
        )

        vc.present(
            alert,
            animated: true
        )
    }
}
