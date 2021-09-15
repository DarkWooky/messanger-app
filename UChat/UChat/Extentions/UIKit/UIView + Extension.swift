//
//  UIView + Extension.swift
//  UChat
//
//  Created by Egor Mihalevich on 15.09.21.
//

import UIKit

extension UIView {

    func applyGradients(cornerRadius: CGFloat) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, startColor: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), endColor: #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1))
        if let gradientLayer = gradientView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = self.bounds
            gradientLayer.cornerRadius = cornerRadius

            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
}
