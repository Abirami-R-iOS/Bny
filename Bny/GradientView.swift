//
//  GradientView.swift
//  Bny
//
//  Created by Abirami on 23/05/26.
//

import UIKit

enum GradientCornerStyle {
    case all
    case top
    case bottom
    case left
    case right
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
    case custom(CACornerMask)
}

extension UIView {

    func applyGradient(
        colors: [UIColor],
        startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0),
        endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0),
        cornerRadius: CGFloat = 0,
        cornerStyle: GradientCornerStyle = .all
    ) {

        // Remove old gradients
        layer.sublayers?.removeAll(where: {
            $0 is CAGradientLayer
        })

        // Gradient Layer
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = colors.map { $0.cgColor }
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.cornerRadius = cornerRadius

        // Apply corner radius
        layer.cornerRadius = cornerRadius
        clipsToBounds = true

        // Corner Styles
        switch cornerStyle {

        case .all:
            layer.maskedCorners = [
                .layerMinXMinYCorner,
                .layerMaxXMinYCorner,
                .layerMinXMaxYCorner,
                .layerMaxXMaxYCorner
            ]

        case .top:
            layer.maskedCorners = [
                .layerMinXMinYCorner,
                .layerMaxXMinYCorner
            ]

        case .bottom:
            layer.maskedCorners = [
                .layerMinXMaxYCorner,
                .layerMaxXMaxYCorner
            ]

        case .left:
            layer.maskedCorners = [
                .layerMinXMinYCorner,
                .layerMinXMaxYCorner
            ]

        case .right:
            layer.maskedCorners = [
                .layerMaxXMinYCorner,
                .layerMaxXMaxYCorner
            ]

        case .topLeft:
            layer.maskedCorners = [
                .layerMinXMinYCorner
            ]

        case .topRight:
            layer.maskedCorners = [
                .layerMaxXMinYCorner
            ]

        case .bottomLeft:
            layer.maskedCorners = [
                .layerMinXMaxYCorner
            ]

        case .bottomRight:
            layer.maskedCorners = [
                .layerMaxXMaxYCorner
            ]

        case .custom(let corners):
            layer.maskedCorners = corners
        }

        // Insert Gradient
        layer.insertSublayer(gradient, at: 0)
    }
    
    func applyPremiumCardStyle() {

           // Gradient
           let gradientLayer = CAGradientLayer()
           gradientLayer.colors = [
               UIColor(hex: "#182133").cgColor,
               UIColor(hex: "#111827").cgColor
           ]

           gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
           gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

           gradientLayer.frame = bounds
           gradientLayer.cornerRadius = 22

           // Border
           layer.borderWidth = 1
           layer.borderColor = UIColor.white
               .withAlphaComponent(0.08)
               .cgColor

           // Corner Radius
           layer.cornerRadius = 22
           clipsToBounds = true

           // Remove old gradient if exists
           layer.sublayers?.removeAll(where: {
               $0 is CAGradientLayer
           })

           layer.insertSublayer(
               gradientLayer,
               at: 0
           )
       }
    
    func applyPremiumNavyCard() {

            // Remove old gradients
            layer.sublayers?.removeAll(where: {
                $0 is CAGradientLayer
            })

            // Gradient
            let gradientLayer = CAGradientLayer()

            gradientLayer.colors = [
                UIColor(hex: "#1A2236").cgColor,
                UIColor(hex: "#141C2E").cgColor
            ]

            // Android angle 270 equivalent
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

            gradientLayer.frame = bounds
            gradientLayer.cornerRadius = 14

            // Border
            layer.borderWidth = 1
            layer.borderColor = UIColor.white
                .withAlphaComponent(0.09)
                .cgColor

            // Corner Radius
            layer.cornerRadius = 14
            clipsToBounds = true

            // Insert Gradient
            layer.insertSublayer(
                gradientLayer,
                at: 0
            )
        }
    
    func applyButtonRedGradient() {

            // Remove old gradients
            layer.sublayers?.removeAll(where: {
                $0 is CAGradientLayer
            })

            // Gradient
            let gradientLayer = CAGradientLayer()

            gradientLayer.colors = [
                UIColor(hex: "#E11D48").cgColor,
                UIColor(hex: "#BE123C").cgColor
            ]

            // Android angle = 315 equivalent
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)

            gradientLayer.frame = bounds
            gradientLayer.cornerRadius = 16

            // Border
            layer.borderWidth = 1
            layer.borderColor = UIColor.white
                .withAlphaComponent(0.06)
                .cgColor

            // Corner Radius
            layer.cornerRadius = 16
            clipsToBounds = true

            // Insert Gradient
            layer.insertSublayer(
                gradientLayer,
                at: 0
            )
        }
    
    func applyGlassBackground() {

            // Background
            backgroundColor = UIColor.white.withAlphaComponent(0.20)

            // Corner Radius
            layer.cornerRadius = 12
            clipsToBounds = true

            // Border
            layer.borderWidth = 1
            layer.borderColor = UIColor.white
                .withAlphaComponent(0.50)
                .cgColor
        }
}
