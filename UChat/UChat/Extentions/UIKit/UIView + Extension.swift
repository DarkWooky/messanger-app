//
//  UIView + Extension.swift
//  UChat
//
//  Created by Egor Mihalevich on 15.09.21.
//

import UIKit

extension UIView {

    func applyGradients(cornerRadius: CGFloat = 0) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, startColor: UIColor(named: "Color-1"), endColor: UIColor(named: "Color"))
        if let gradientLayer = gradientView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = self.bounds
            gradientLayer.cornerRadius = cornerRadius

            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
}
