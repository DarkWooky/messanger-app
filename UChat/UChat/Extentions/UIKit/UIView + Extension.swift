//
//  UIView + Extension.swift
//  UChat
//
//  Created by Egor Mihalevich on 15.09.21.
//

import UIKit

extension UIView {

    func applyGradients(cornerRadius: CGFloat = 0, startColor: UIColor, endColor: UIColor) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientView = GradientView(from: .bottomLeading, to: .topTrailing, startColor: startColor, endColor: endColor)
        if let gradientLayer = gradientView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = self.bounds
            gradientLayer.cornerRadius = cornerRadius

            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
}
