//
//  UIImage + Extention.swift
//  ChatU
//
//  Created by Egor Mihalevich on 1.09.21.
//

import UIKit

extension UIImageView {
    
    convenience init(image: UIImage?, contentMode: UIView.ContentMode) {
        self.init()
        
        self.image = image
        self.contentMode = contentMode
    }
}
