////
////  InputAccesoryView.swift
////  Bny
////
////  Created by Abirami on 08/07/26.
////
//
//import Foundation
//import UIKit
//
//final class InputAccessoryView: UIView {
//
//    private let cancelAction: Selector
//    private let doneAction: Selector
//    private weak var target: AnyObject?
//
//    init(target: AnyObject,
//         doneAction: Selector,
//         cancelAction: Selector) {
//
//        self.target = target
//        self.doneAction = doneAction
//        self.cancelAction = cancelAction
//
//        super.init(frame: CGRect(x: 0,
//                                 y: 0,
//                                 width: UIScreen.main.bounds.width,
//                                 height: 50))
//
//        setupUI()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setupUI() {
//
//        backgroundColor = .clear
//
//        let cancelButton = UIButton(type: .system)
//        cancelButton.setTitle(AppStrings.cancel, for: .normal)
//        cancelButton.setTitleColor(.silverClr, for: .normal)
//        cancelButton.addTarget(target,
//                               action: cancelAction,
//                               for: .touchUpInside)
//
//        let doneButton = UIButton(type: .system)
//        doneButton.setTitle(AppStrings.done, for: .normal)
//        doneButton.setTitleColor(.bnyRed, for: .normal)
//        doneButton.addTarget(target,
//                             action: doneAction,
//                             for: .touchUpInside)
//
//        let stackView = UIStackView(arrangedSubviews: [
//            cancelButton,
//            UIView(),
//            doneButton
//        ])
//
//        stackView.axis = .horizontal
//        stackView.alignment = .fill
//        stackView.distribution = .fill
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//
//        addSubview(stackView)
//
//        NSLayoutConstraint.activate([
//            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//            stackView.topAnchor.constraint(equalTo: topAnchor),
//            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//    }
//}
//
import UIKit
import Foundation

final class InputAccessoryView: UIView {

    private let cancelAction: Selector
    private let doneAction: Selector
    private weak var target: AnyObject?

    init(target: AnyObject,
         doneAction: Selector,
         cancelAction: Selector) {

        self.target = target
        self.doneAction = doneAction
        self.cancelAction = cancelAction

        super.init(frame: CGRect(x: 0,
                                 y: 0,
                                 width: UIScreen.main.bounds.width,
                                 height: 60))

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    private func setupUI() {
//
//        backgroundColor = .clear
//
//        // Glass background
//        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
//        blurView.translatesAutoresizingMaskIntoConstraints = false
//        blurView.layer.cornerRadius = 18
//        blurView.layer.masksToBounds = true
//        addSubview(blurView)
//
//        NSLayoutConstraint.activate([
//            blurView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            blurView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            blurView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
//            blurView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)//-6
//        ])
//
//        let cancelButton = createButton(
//            title: AppStrings.cancel,
//            titleColor: .secondaryLabel,
//            backgroundColor: UIColor.silverClr,
//            action: cancelAction
//        )
//
//        let doneButton = createButton(
//            title: AppStrings.done,
//            titleColor: .white,
//            backgroundColor: UIColor.bnyRed,
//            action: doneAction
//        )
//
//        let stack = UIStackView(arrangedSubviews: [
//            cancelButton,
//            UIView(),
//            doneButton
//        ])
//
//        stack.axis = .horizontal
//        stack.alignment = .center
//        stack.translatesAutoresizingMaskIntoConstraints = false
//
//        blurView.contentView.addSubview(stack)
//
//        NSLayoutConstraint.activate([
//            stack.leadingAnchor.constraint(equalTo: blurView.contentView.leadingAnchor, constant: 16),
//            stack.trailingAnchor.constraint(equalTo: blurView.contentView.trailingAnchor, constant: -16),
//            stack.topAnchor.constraint(equalTo: blurView.contentView.topAnchor),
//            stack.bottomAnchor.constraint(equalTo: blurView.contentView.bottomAnchor)
//        ])
//    }
    
    private func setupUI() {

        backgroundColor = .clear

        let cancelButton = createButton(
            title: AppStrings.cancel,
            titleColor: .whiteClr,
            backgroundColor: UIColor.clear,
            action: cancelAction
        )

        let doneButton = createButton(
            title: AppStrings.done,
            titleColor: .whiteClr,
            backgroundColor: UIColor.clear,
            action: doneAction
        )

        let stackView = UIStackView(arrangedSubviews: [
            cancelButton,
            UIView(),
            doneButton
        ])

        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    private func createButton(title: String,
                              titleColor: UIColor,
                              backgroundColor: UIColor,
                              action: Selector) -> UIButton {

        let button = UIButton(type: .system)

        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)

        button.backgroundColor = backgroundColor

        button.titleLabel?.font = .poppinsSemiBold(size: 15)

        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true

        button.contentEdgeInsets = UIEdgeInsets(
            top: 10,
            left: 20,
            bottom: 10,
            right: 20
        )

        button.addTarget(target,
                         action: action,
                         for: .touchUpInside)

        return button
    }
    

//    private func createButton(title: String,
//                              titleColor: UIColor,
//                              backgroundColor: UIColor,
//                              action: Selector) -> UIButton {
//
//        let button = UIButton(type: .system)
//
//        button.setTitle(title, for: .normal)
//        button.setTitleColor(titleColor, for: .normal)
//
//        button.backgroundColor = backgroundColor
//
//        button.titleLabel?.font = .systemFont(ofSize: 15,
//                                              weight: .semibold)
//
//        button.layer.cornerRadius = 12
//        button.layer.masksToBounds = true
//
//        button.contentEdgeInsets = UIEdgeInsets(
//            top: 8,
//            left: 18,
//            bottom: 8,
//            right: 18
//        )
//
//        button.addTarget(target,
//                         action: action,
//                         for: .touchUpInside)
//
//        return button
//    }
}
