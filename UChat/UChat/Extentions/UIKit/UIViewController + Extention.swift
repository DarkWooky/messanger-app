//
//  UIViewController + Extention.swift
//  ChatU
//
//  Created by Egor Mihalevich on 1.09.21.
//

import UIKit

extension UIViewController {
    func assignBackground() {
        let background = UIImage(named: "background")

        var imageView: UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
}
