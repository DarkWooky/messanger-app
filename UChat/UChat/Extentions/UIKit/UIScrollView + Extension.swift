//
//  UIScrollView + Extension.swift
//  UChat
//
//  Created by Egor Mikhalevich on 4.10.21.
//

import UIKit

extension UIScrollView {

    var isAtBottom: Bool {
        return contentOffset.y >= verticalOffsetForBottom
    }

    var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInset = contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        return scrollViewBottomOffset
    }
}
