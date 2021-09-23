//
//  OneLineTextField.swift
//  UChat
//
//  Created by Egor Mihalevich on 1.09.21.
//

import UIKit

class OneLineTextField: UITextField {
    convenience init(font: UIFont? = .helvetica20(),
                     isSecure: Bool = true,
                     placeholder: String = "",
                     textContentType: UITextContentType! = .none) {
        self.init()
        
        self.font = font
        self.borderStyle = .none
        self.clearButtonMode = .whileEditing
        self.isSecureTextEntry = isSecure
        self.textContentType = textContentType
        self.autocapitalizationType = .none
        self.placeholder = placeholder
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var bottomView = UIView()
        bottomView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomView.backgroundColor = UIColor(named: "customColor")
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomView)
        
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 3),
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
