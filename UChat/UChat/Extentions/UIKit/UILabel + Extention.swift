//
//  UILabel + Extention.swift
//  ChatU
//
//  Created by Egor Mihalevich on 1.09.21.
//

import UIKit

extension UILabel {
    convenience init(text: String,
                     font: UIFont? = .helvetica20(),
                     textColor: UIColor? = .label)
    {
        self.init()

        self.text = text
        self.font = font
        self.textColor = textColor
    }
}
