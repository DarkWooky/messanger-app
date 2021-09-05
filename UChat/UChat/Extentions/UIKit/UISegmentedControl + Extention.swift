//
//  UISegmentedControl + Extention.swift
//  UChat
//
//  Created by Egor Mihalevich on 3.09.21.
//

import UIKit

extension UISegmentedControl {
    convenience init(first: String, second: String) {
        self.init()
        self.insertSegment(withTitle: first, at: 0, animated: true)
        self.insertSegment(withTitle: second, at: 1, animated: true)
        self.selectedSegmentIndex = 0
        self.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.helvetica14()!,
                                     NSAttributedString.Key.foregroundColor: UIColor(named: "customColor-1")!], for: .normal)
        self.selectedSegmentTintColor = UIColor(named: "projectColor")
    }
}
