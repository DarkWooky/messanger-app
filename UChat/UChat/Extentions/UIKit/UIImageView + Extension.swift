//
//  UIImageView + Extension.swift
//  UChat
//
//  Created by Egor Mihalevich on 15.09.21.
//

import UIKit

extension UIImageView {

    convenience init(image: UIImage, contentMode: UIView.ContentMode) {
        self.init()

        self.image = image
        self.contentMode = contentMode
    }
}

extension UIImageView {
    func setupColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
