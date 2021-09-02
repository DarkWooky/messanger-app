//
//  UIViewController + Extention.swift
//  ChatU
//
//  Created by Egor Mihalevich on 1.09.21.
//

import UIKit

extension UIViewController {
    func assignBackground(backgroundName: String) {
        let background = UIImage(named: backgroundName)

        var imageView: UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
//    func setupScrollView(set scrollView: UIScrollView, on view: UIView, with contentView: UIView) {
//        var scrollView = scrollView
//        var contentView = contentView
//        let screensize: CGRect = UIScreen.main.bounds
//        let screenWidth = screensize.width
//        let screenHeight = screensize.height
//        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
//        scrollView.contentSize = CGSize(width: screenWidth, height: Constants.maxScreenHeight.rawValue)
//        contentView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
//
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//    }
}
