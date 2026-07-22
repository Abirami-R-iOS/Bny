//
//  KeyboardHandler.swift
//  Bny
//
//  Created by Abirami on 22/07/26.
//

import Foundation
import UIKit

final class KeyboardHandler {

    private weak var scrollView: UIScrollView?
    private weak var viewController: UIViewController?

    init(viewController: UIViewController,
         scrollView: UIScrollView) {

        self.viewController = viewController
        self.scrollView = scrollView
    }

    func registerKeyboardNotifications() {

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    func unregisterKeyboardNotifications() {

        NotificationCenter.default.removeObserver(self)
    }

    func scrollToTextField(_ textField: UITextField) {

        guard let scrollView = scrollView else { return }

        let rect = textField.convert(textField.bounds, to: scrollView)

        scrollView.scrollRectToVisible(
            rect.insetBy(dx: 0, dy: -40),
            animated: true
        )
    }

    @objc
    private func keyboardWillShow(_ notification: Notification) {

        guard
            let scrollView = scrollView,
            let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }

        scrollView.contentInset.bottom = keyboardFrame.height + 20
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardFrame.height + 20
    }

    @objc
    private func keyboardWillHide(_ notification: Notification) {

        guard let scrollView = scrollView else { return }

        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }
    
    
    func scrollToTextView(_ textView: UITextView) {

        guard let scrollView = scrollView else { return }

        let rect = textView.convert(textView.bounds, to: scrollView)

        scrollView.scrollRectToVisible(
            rect.insetBy(dx: 0, dy: -40),
            animated: true
        )
    }
}
