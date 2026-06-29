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
    
    func applyRewardBackgroundGradient() {
        applyGradient(
            colors: [
                UIColor(hex: "#091326"),
                UIColor(hex: "#0A1322"),
                UIColor(hex: "#050B14")
            ],
            startPoint: CGPoint(x: 0.5, y: 0.0), // Top
            endPoint: CGPoint(x: 0.5, y: 1.0)    // Bottom (270°)
        )
        
        
        addRadialGradient(
            center: CGPoint(x: 1.15, y: -0.10),
            radius: 260,
            colors: [
                UIColor(hex: "#E11D48").withAlphaComponent(0.27),
                UIColor(hex: "#E11D48").withAlphaComponent(0.07),
                UIColor.clear
            ]
        )
        
        addRadialGradient(
            center: CGPoint(x: -0.10, y: 0.55),
            radius: 180,
            colors: [
                UIColor(hex: "#2B5CFF").withAlphaComponent(0.03),
                UIColor.clear
            ]
        )
        
        addRadialGradient(
            center: CGPoint(x: 0.5, y: 1.20),
            radius: 320,
            colors: [
                UIColor(hex: "#0F172A").withAlphaComponent(0.07),
                UIColor.clear
            ]
        )
    }
}

extension UIView {
    
    func addRadialGradient(
        center: CGPoint,
        radius: CGFloat,
        colors: [UIColor]
    ) {
        
        let size = CGSize(width: radius * 2, height: radius * 2)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let cgColors = colors.map { $0.cgColor } as CFArray
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let locations: [CGFloat] = [0.0, 0.6, 1.0]
        
        guard let gradient = CGGradient(
            colorsSpace: colorSpace,
            colors: cgColors,
            locations: locations
        ) else { return }
        
        context.drawRadialGradient(
            gradient,
            startCenter: CGPoint(x: radius, y: radius),
            startRadius: 0,
            endCenter: CGPoint(x: radius, y: radius),
            endRadius: radius,
            options: .drawsAfterEndLocation
        )
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            UIGraphicsEndImageContext()
            return
        }
        
        UIGraphicsEndImageContext()
        
        let layer = CALayer()
        layer.contents = image
        layer.frame = CGRect(
            x: bounds.width * center.x - radius,
            y: bounds.height * center.y - radius,
            width: radius * 2,
            height: radius * 2
        )
        
        self.layer.insertSublayer(layer, at: 0)
    }
    
    func applyTabParentStyle() {
        layer.backgroundColor = UIColor(hex: "#161D2E").cgColor
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.withAlphaComponent(0.08).cgColor // #14FFFFFF
        clipsToBounds = true
    }
    
    func applyRewardBannerGradient() {
        applyGradient(
            colors: [
                UIColor(hex: "#111827"),
                UIColor(hex: "#220000"),
                UIColor(hex: "#4D0000")
            ],
            startPoint: CGPoint(x: 0.0, y: 0.5),
            endPoint: CGPoint(x: 1.0, y: 0.5),
            cornerRadius: 24
        )
    }
}

extension UIButton {
    
    func removeSelectedTabGradient() {
            layer.sublayers?.removeAll {
                $0 is CAGradientLayer
            }
        }

    func applySelectedTabGradient() {

        // பழைய gradient remove
        layer.sublayers?.removeAll {
            $0 is CAGradientLayer
        }

        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.cornerRadius = layer.cornerRadius

        gradient.colors = [
            UIColor(hex: "#6E0B1F").cgColor,
            UIColor(hex: "#A50E2D").cgColor,
            UIColor(hex: "#D81B45").cgColor
        ]

        // Bottom Left → Top Right (315°)
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.0)

        layer.insertSublayer(gradient, at: 0)
    }
}
